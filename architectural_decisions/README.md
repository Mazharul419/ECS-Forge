# ECS-Forge: Key Architectural Decisions
This doc summarises the key architectural decisions made in this project:

| Decision | Choice Made | Alternative | Rationale |
|---|---|---|---|
| IaC framework | Terragrunt | Raw Terraform | DRY module structure: Eliminates repeated backend/provider config; Simpler: Can use `run --all` to execute across all modules once; Ordered: Handles dependency ordering |
| State backend | S3 Remote State | Local state | Highly available state; Protected against compromise with encryption at rest (KMS) |
| State backend locking | S3 native locking | S3 + DynamoDB | Secure: Prevents concurrent writes upon plan/apply; Modern: Removes DynamoDB dependency which will be deprecated|
| CI/CD pipeline | GitHub Actions | Jenkins / CircleCI | Native GitHub integration; OIDC support; no additional tooling to host |
| Container orchestration | ECS Fargate | EC2-based ECS / self-managed | Serverless compute; no server management |
| Private connectivity | VPC Endpoints | NAT Gateway | Cheaper: Cheaper running price and per-GB data processing costs; Secure - keeps traffic off the public internet |
| Private connectivity | Least-privilege segmentation for security groups | Flat security groups open to 0.0.0.0/0 | Secure: Only required resources allowed to talk to each other at EVERY path; limits blast radius if any single component is compromised; no resource is directly reachable from the internet except the ALB |
| Multi-environment strategy | Separate Terragrunt envs (dev/prod) | Workspaces | Cleaner state isolation; mirrors real-world team patterns |
| CI/CD auth | OIDC (GitHub Actions > AWS) | Long-lived IAM access keys | No static credentials stored in GitHub; short-lived tokens per workflow run; security best practice |
| TLS termination | AWS Certificate Manager | Self-signed / Let's Encrypt on container | Managed certificate renewal; terminates at the load balancer; no cert handling inside the app |
| Container registry | ECR | Docker Hub | Native AWS integration, no external registry dependency, IAM-controlled access |
| Availablity Zone selection  | Double AZ setup for prod | Single AZ setup | Reliability: Enables fault isolation should single AZ go down |
| Tagging strategy | Provider-level default tags with resource-level Name tags | Manually tagging every resource individually | Eliminates tag duplication across modules; guaranteed consistency; aligns with Terragrunt DRY principles; |