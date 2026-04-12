# ECS-Forge: Key Architectural Decisions
This doc summarises the key architectural decisions made in this project:

| Decision | Choice Made | Alternative | Rationale |
|---|---|---|---|
| IaC framework | Terragrunt | Raw Terraform | DRY module structure: Eliminates repeated backend/provider config; Simpler: Can use `run --all` to execute across all modules once; Ordered: Handles dependency ordering |
| Availablity Zone selection  | Double AZ setup for prod | Single AZ setup | Reliability: Enables fault isolation should single AZ go down |
| Private connectivity | VPC Endpoints | NAT Gateway | Cheaper: Cheaper running price and per-GB data processing costs; Secure - keeps traffic off the public internet |
| CI/CD auth | OIDC (GitHub Actions > AWS) | Long-lived IAM access keys | No static credentials stored in GitHub; short-lived tokens per workflow run; security best practice |
| State backend | S3 Remote State | Local state | Highly available state; Protected against compromise with encryption at rest (KMS) |
| State backend locking | S3 native locking | S3 + DynamoDB | Secure: Prevents concurrent writes upon plan/apply; Modern: Removes DynamoDB dependency which will be deprecated|
| Container orchestration | ECS Fargate | EC2-based ECS / self-managed | Serverless compute; no server management |
| Container registry | ECR | Docker Hub | Native AWS integration, no external registry dependency, IAM-controlled access |
| TLS termination | AWS Certificate Manager | Self-signed / Let's Encrypt on container | Managed certificate renewal; terminates at the load balancer; no cert handling inside the app |
| Multi-environment strategy | Separate Terragrunt envs (dev/prod) | Workspaces | Cleaner state isolation; mirrors real-world team patterns |
| CI/CD pipeline | GitHub Actions | Jenkins / CircleCI | Native GitHub integration; OIDC support; no additional tooling to host |
| Tagging strategy | Resource/provider level tagging | No tagging | Enables clear ownership of resources; Clear cost breakdown; Better budgeting |
| Availability Zone selection | Dynamic Availability Zone retrieval | Static Availability Zones | Avoids hardcoding AZs; Makes configuration more flexible |