#!/bin/bash
set -e

# Configuration
PROJECT_NAME="ecs-project"
AWS_REGION="eu-west-2"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REPO_NAME="${PROJECT_NAME}-global-ecr"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INFRA_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Environment variables
export TG_NON_INTERACTIVE=true
export AWS_PAGER=""

# ============================================================
# CONFIRMATION
# ============================================================

echo ""
echo -e "============================================================"
echo -e "  WARNING: DESTRUCTIVE OPERATION"
echo -e "============================================================"
echo ""
echo "This will destroy following bootstrap resources:"
echo "  - ECR repository (and all images)"
echo "  - GitHub OIDC role"
echo "  - S3 state bucket (optional)"
echo ""
echo -e "Account: $ACCOUNT_ID"
echo -e "Region: $AWS_REGION"
echo ""
read -p "Type 'destroy' to confirm: " CONFIRM

if [ "$CONFIRM" != "destroy" ]; then
  echo "Aborted."
  exit 0
fi

# ============================================================
# DESTROY IN REVERSE ORDER
# ============================================================

echo "Destroying Bootstrap Infrastructure"

DESTROY_ORDER=(
  "live/global/ecr"
  "live/global/oidc"
)

for module in "${DESTROY_ORDER[@]}"; do
  if [ -d "$INFRA_DIR/$module" ]; then
    echo "Destroying: $module"
    cd "$INFRA_DIR/$module"
    
    terragrunt destroy -auto-approve || {
      echo "Failed to destroy $module (continuing...)"
    }
  else
    echo "Skipping $module (not found)"
  fi
done

# ============================================================
# MANUAL CLEANUP FOR STUBBORN RESOURCES
# ============================================================

echo "Cleaning Up Stubborn Resources"

# ECR Images
echo "Checking for ECR repository..."
if aws ecr describe-repositories --repository-names "$ECR_REPO_NAME" --region "$AWS_REGION" &> /dev/null; then
  echo "Deleting ECR images..."

  IMAGE_IDS=$(aws ecr list-images \
    --repository-name "$ECR_REPO_NAME" \
    --region "$AWS_REGION" \
    --query 'imageIds[*]' \
    --output json)
  
  if [ "$IMAGE_IDS" != "[]" ]; then
    aws ecr batch-delete-image \
      --repository-name "$ECR_REPO_NAME" \
      --region "$AWS_REGION" \
      --image-ids "$IMAGE_IDS" > /dev/null 2>&1 || true
  fi

  echo "Deleting ECR repository..."
  aws ecr delete-repository \
    --repository-name "$ECR_REPO_NAME" \
    --region "$AWS_REGION" \
    --force 2>/dev/null || true
  echo "ECR deleted"
fi

# ============================================================
# DELETE S3 BUCKET
# ============================================================

echo "S3 State Bucket"

BUCKET_NAME="${PROJECT_NAME}-terraform-state-${ACCOUNT_ID}-${AWS_REGION}"

echo -e "${YELLOW}Delete S3 state bucket? This removes all Terraform state history.${NC}"
read -p "Delete bucket '$BUCKET_NAME'? (y/N): " DELETE_BUCKET

if [ "$DELETE_BUCKET" = "y" ] || [ "$DELETE_BUCKET" = "Y" ]; then
  if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then

    echo "Deleting bucket and all contents..."

    # Force delete (delete via python to handle versioned objects)
python3 - <<EOF
import boto3
import sys

bucket_name = "$BUCKET_NAME"
region = "$AWS_REGION"

try:
    s3 = boto3.resource('s3', region_name=region)
    bucket = s3.Bucket(bucket_name)
    
    print(f"Deleting all object versions from {bucket_name}...")
    bucket.object_versions.delete()
    
    print(f"Deleting bucket {bucket_name}...")
    bucket.delete()
    
    print(" Bucket deleted successfully")
except Exception as e:
    print(f" Error: {e}", file=sys.stderr)
    sys.exit(1)
EOF

    if [ $? -eq 0 ]; then
      echo "S3 bucket deleted"
    else
      echo "Failed to delete bucket"
      exit 1
    fi
  else
    echo "Bucket not found or already deleted"
  fi
else
  echo "Skipped S3 bucket deletion (state preserved)"
fi

# ============================================================
# CLEANUP LOCAL FILES
# ============================================================

echo "Cleaning Up Local Files"

cd "$INFRA_DIR"

echo "Removing Terragrunt cache..."
find . -type d -name ".terragrunt-cache" -exec rm -rf {} + 2>/dev/null || true

echo "Removing Terraform files..."
find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
find . -type f -name ".terraform.lock.hcl" -delete 2>/dev/null || true

echo "Local files cleaned"

# ============================================================
# SUMMARY
# ============================================================

echo ""
echo ""
echo -e "============================================================"
echo -e " TEARDOWN COMPLETE"
echo -e "============================================================"
echo ""
echo -e "RESOURCES DESTROYED:"
echo ""
echo "ECR repository"
echo "OIDC provider and role"

if [ "$DELETE_BUCKET" = "y" ] || [ "$DELETE_BUCKET" = "Y" ]; then
  echo "S3 state bucket"
else
  echo "S3 state bucket (preserved)"
fi

echo ""
echo -e "============================================================"
echo ""