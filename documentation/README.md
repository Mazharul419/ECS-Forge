# Intro

ECS-Forge is an end-to-end deployment of the code-server application via ECS Fargate. Upon push to main, or on successful pull request - a Docker image of the application is automatically built and pushed to ECR - where via manual trigger in Github Actions, deployment to Dev and Prod environment (or both) takes place.

The application is hosted on AWS - hidden behind an application load balancer.



It includes:

-	A bootstrap script for deploying the remote S3 backend, OIDC role, and ECR repository

-	A destroy script for destroying the above resources

-	App repo (github link)

-	Dockerfile (builds image)

-	.dockerignore, .gitignore

-	Github workflows file with build + push image, deploy image, deploy infrastructure, destroy infrastructure

</div>

### Table of Contents

[Links](https://github.com/Mazharul419/ECS-Forge/edit/main/documentation/README.md#links)

[Architecture Diagram]()

# Links

Miro board: [ECS Project](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/a35fb6e5-fe3b-40cc-92b8-ed32cba2544f)

[GitHub - Mazharul419/ECS-Forge](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/6f4712c6-1ff0-4d45-82e0-3c53a06626c8)



# Architecture Diagram

![ECS Diagram Detailed-Copy of With VPC Endpoint - Detailed](https://capacities-files.s3.eu-central-1.amazonaws.com/private/0eb2e9c6-b8df-41fc-8359-95d46803c8b4/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=1fe30188d46586f9e95dbd63382d9aa39c0fc86a1724963f10cec49d69007391&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[ECS Diagram Detailed-Copy of With VPC Endpoint - Detailed - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/0eb2e9c6-b8df-41fc-8359-95d46803c8b4)

---

#                                                        Summary

[End-to-End Deployment of Applications on AWS with Fargate 🚀](https://www.loom.com/share/2402051f736d492990df21803c33065a)[End-to-End Deployment of Applications on AWS with Fargate 🚀 - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/748c121e-9bc1-4b59-b2f6-79e4b4246fb1)

---

#                                                  Detailed Demo

[End-to-End Deployment of Code Server on AWS](https://www.loom.com/share/748625955d4243fd9d828fcf824bd1c3)[End-to-End Deployment of Code Server on AWS - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/dd98d4b8-a15b-4002-b565-2b4ef25710d5)

---



## Key Features

- 35% Cost reduction through use of VPC endpoints vs NAT Gateways

- Enhanced security posture using short-lived OIDC credentials

- App protected via intelligent routing through Application Load Balancer (ALB)

- 95% in Docker image size reduction through multi-stage builds

- Adherence to Don't-Repeat-Yourself (DRY) principle through Terragrunt deployment

- Secured remote state through S3 native locking



## Built With

---

#### Application setup: 

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/bf5235a6-93d4-4f7e-ae54-3e6a6a9f7d0f/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=d4fe5e92730af868e43b2fc4b8db07eb3c6a84d444337b0ecded64dae8d905e3&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/bf5235a6-93d4-4f7e-ae54-3e6a6a9f7d0f)

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/ba79bc76-820d-45a2-8657-8b9afb1d20bd/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=5ec2276a26202c860f61297e03d2d1c7b03428f4f2081af0fb41b1871b5ab67c&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/ba79bc76-820d-45a2-8657-8b9afb1d20bd)

---

#### DNS/Cloud Infrastructure:

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/1542a0a7-c568-45a9-9f17-2b2344418971/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=2d5a3a6857ee22f28553e7f3b0fcdd23544cdf329dc799cded8e31eac42b3da8&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/1542a0a7-c568-45a9-9f17-2b2344418971)

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/62d86468-4705-4663-b3b0-8c90d787a9fa/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=08da038380251aa595788b806211fb537d68e85ec5623b3173b05dab5f9c1708&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/62d86468-4705-4663-b3b0-8c90d787a9fa)

---

---

#### Infrastructure-As-Code:

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/2d0fdd45-e65f-49af-9e76-a2a4951e9919/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=66c3af0fc6fbe32c377c9c418da490da2151cd476c3f384b13d73153fe52c6b3&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/2d0fdd45-e65f-49af-9e76-a2a4951e9919)

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/6ff99bac-472e-4d40-bb5d-bc4c7cdae1b7/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=3db54f3c0e6599cacd731cefdd1be5349edc009b15a9af5a8cc7d77d86ab9b33&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/6ff99bac-472e-4d40-bb5d-bc4c7cdae1b7)

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/9b1ebeb2-174a-44eb-9a42-2fae902b9a09/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=b0fb542889d5948b89d3439044789b62fd514187238a3a9ae7be0d5909db7685&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/9b1ebeb2-174a-44eb-9a42-2fae902b9a09)

---

#### Version Control and CI/CD:

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/de1d422b-98eb-408a-8d46-4805fbb4b296/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=cbbd35f5b6daa2f75029daa72815f2c974d36ab7820d46f96bafdf5a77881297&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/de1d422b-98eb-408a-8d46-4805fbb4b296)

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/65baba7d-7b0d-4d74-a49a-468b82f27183/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=382ebc6a21ffa45b35a163bd1966edc5ccb87163658b769e72c4465dea132441&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/65baba7d-7b0d-4d74-a49a-468b82f27183)

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/185ad92e-aa2a-47b3-9eca-dd75ae2b4f5d/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=37980ac867412df08584f0242670acddcf83c9a3e9ea6c7001bf007cb882e8ba&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/185ad92e-aa2a-47b3-9eca-dd75ae2b4f5d)

---



#### Additional Scripting Languages:

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/ed83873c-de3d-42eb-ab84-aa8ca684c4a2/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=1fdc187d466431860af5e12d74af38f5c573c5f31088b435c3bba5108ce406b7&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/ed83873c-de3d-42eb-ab84-aa8ca684c4a2)

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/29a590b6-92d8-4423-a9fe-e250009d81fc/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=4cd29b6471da12065afa7a54cc814aae0cd25bc355e395ca3a979151a0f06c43&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/29a590b6-92d8-4423-a9fe-e250009d81fc)

<!-- restart numbering -->

# Traffic Flow Explained

## Access to website

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/ce5be6b9-2b98-4142-bb70-1cabd8dc3727/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T093514Z&X-Amz-Expires=43200&X-Amz-Signature=a9b805365e3f128274138b6b9b7d2afe99eb2155becb4f62c5feaff5839c6b7f&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image
 - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/ce5be6b9-2b98-4142-bb70-1cabd8dc3727)


To access the live application in production environment, the user types in ***tm.mazharulislam.dev***(or ***tm-dev.mazharulislam.dev*** if accessing development environment).

A DNS (Domain Name System) query takes place - the client sends out tm.mazharulislam.dev and receives the IP address of the public-facing Application Load Balancer (ALB) allowing it to connect to the application hosted in AWS.

![image](https://capacities-files.s3.eu-central-1.amazonaws.com/private/8756b937-d7ab-48cd-8576-1f2925e75a22/raw.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA5VTNRR6EBR56K2NK%2F20260329%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20260329T110405Z&X-Amz-Expires=43200&X-Amz-Signature=8a1480f580893048151797a17c7fceb96af6081edf8761e6115bc12be3366c61&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
[image - Notes](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/8756b937-d7ab-48cd-8576-1f2925e75a22)


Assuming there is no cache stored at any stage - [the following](https://www.cloudflare.com/en-gb/learning/dns/what-is-dns/) will happen:

1. User types in "tm.mazharulislam.dev" - the client checks locally to see if the IP address is cached - within it's browser, or the OS

2. The query travels into the Internet and is received by a DNS resolver

3. The root server responds with the address of a Top Level Domain (TLD) DNS server .dev

4. The resolver then makes a request to the TLD server carrying .dev domain which responds with the IP address of the domain’s nameserver mazharulislam.dev

5. The resolver sends a query to the domain’s nameserver - since a subdomain **tm** is present there is an [additional nameserver](https://www.cloudflare.com/en-gb/learning/dns/what-is-dns/#:~:text=It%E2%80%99s%20worth%20mentioning%20that%20in%20instances%20where%20the%20query%20is%20for%20a%20subdomain%20such%20as%20foo.example.com%20or%20blog.cloudflare.com%2C%20an%20additional%20nameserver%20will%20be%20added%20to%20the%20sequence%20after%20the%20authoritative%20nameserver%2C%20which%20is%20responsible%20for%20storing%20the%20subdomain%E2%80%99s%20CNAME%20record.) which holds the CNAME record

6. The [CNAME](https://developers.cloudflare.com/dns/manage-dns-records/reference/dns-record-types/#:~:text=CNAME%20records%20%E2%86%97%20map%20a%20domain%20name%20to%20another%20(canonical)%20domain%20name.%20They%20can%20be%20used%20to%20resolve%20other%20record%20types%20present%20on%20the%20target%20domain%20name.) is mapped to the Application Load Balancer (ALB) DNS name which is returned to the resolver from the nameserver

7. The authoritative name server responds to the DNS resolver with the CNAME record which includes the DNS name of the load balancer*

8. This record is forwarded to the client

9. Client makes a new query for the ALB CNAME

10. The resolver forwards to amazonaws.com domain where the A record is hosted

11. A record containing the [IP addresses of the ALB nodes](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html#w2aab7c21:~:text=The%20Application%20Load%20Balancer%20has%20one%20IP%20address%20per%20enabled,determine%20the%20IP%20addresses%20of%20the%20Application%20Load%20Balancer%20nodes.) is returned to DNS resolver

12. DNS resolver finally returns the IP address of the ALB, allowing the client to send a HTTP request in order to connect to the code-server application



*If the apex zone mazharulislam.dev was used instead (by replacing **tm** with **@**), Cloudflare can return the ALB IP address via a process called [CNAME flattening](https://developers.cloudflare.com/dns/cname-flattening/)(see also [Flattening diagram](https://app.capacities.io/842d982e-dafe-4919-b038-f1da4582566c/8e0ae074-62d8-4d95-8335-f011e0c8108e))



## Load Balancer and remaining

Use this section to explain flow from ALB to tasks in private subnet

Also explain how applications can access AWS services privately



---



---



---



## 3. Technology Stack Explained

### Infrastructure as Code Tools

### Terraform

### Terragrunt

### AWS Services Used

## 4. Project Structure

---

`.
├── Dockerfile
├── LICENSE
├── README.md
├── app
├── infrastructure
│   ├── backend.tf
│   ├── bootstrap
│   ├── live
│   ├── modules
│   ├── provider.tf
│   └── terragrunt.hcl
└── other`


---

`./infrastructure/bootstrap/
├── ReadMe.md
├── bootstrap.sh
└── destroy.sh`


---

`./infrastructure/live`

`├── live
│   ├── _env
│   │   └── common.hcl
│   ├── dev
│   │   ├── acm
│   │   │   └── terragrunt.hcl
│   │   ├── alb
│   │   │   └── terragrunt.hcl
│   │   ├── dns
│   │   │   └── terragrunt.hcl
│   │   ├── ecs
│   │   │   └── terragrunt.hcl
│   │   ├── env.hcl
│   │   ├── security-groups
│   │   │   └── terragrunt.hcl
│   │   ├── vpc
│   │   │   └── terragrunt.hcl
│   │   └── vpc-endpoints
│   │       └── terragrunt.hcl
│   ├── global
│   │   ├── ecr
│   │   │   └── terragrunt.hcl
│   │   └── oidc
│   │       └── terragrunt.hcl
│   └── prod
│       ├── acm
│       │   └── terragrunt.hcl
│       ├── alb
│       │   └── terragrunt.hcl
│       ├── dns
│       │   └── terragrunt.hcl
│       ├── ecs
│       │   └── terragrunt.hcl
│       ├── env.hcl
│       ├── security-groups
│       │   └── terragrunt.hcl
│       ├── vpc
│       │   └── terragrunt.hcl
│       └── vpc-endpoints
│           └── terragrunt.hcl`


---

`./infrastructure/modules`

`├── modules
│   ├── acm
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── alb
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── dns
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ecr
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ecs
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── oidc
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── security-groups
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── vpc
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc-endpoints
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf`


---



---

Structure Explained


5. Root Configuration (terragrunt.hcl)
File Location
Locals Block
Remote State Block
Generate Provider Block


6. Terraform Modules
6.1 VPC Module
Data Source: Availability Zones
VPC Resourcs
Public Subnets
Private Subnets
Public Route Table	16
Private Route Tables	16
Internet Gateway	16
6.2 Security Groups Module	18
ALB Security Group	18
ECS Security Group	18
VPC Endpoints Security Group	19
6.3 VPC Endpoints Module	20
Cost Comparison: NAT Gateway vs VPC Endpoints	20
S3 Gateway Endpoint (FREE)	20
ECR API Endpoint	20
ECR DKR Endpoint	20
CloudWatch Logs Endpoint	21
6.4 ACM (Certificate) Module	22
Certificate Request	22
DNS Validation Record	22
Certificate Validation	22
6.5 ALB (Application Load Balancer) Module	24
Load Balancer	24
Target Group	24
HTTPS Listener	24
HTTP Listener (Redirect)	25
6.6 DNS Module	26
6.7 ECS Module	27
ECS Concepts	27
Cluster	27
CloudWatch Log Group	27
Task Execution Role	27
Task Definition	28
ECS Service	28
6.8 ECR Module	30
6.9 OIDC Module	31
Why OIDC Instead of Access Keys?	31


7. Live Environment Configurations	32
Dev Environment (env.hcl)	32
Prod Environment (env.hcl)	32
Terragrunt Dependencies	32


8. CI/CD Pipelines (GitHub Actions)	34
Key CI/CD Sections	34
OIDC Permissions	34
AWS Authentication	34
Task Definition Update	34


9. Dockerfile Explained	35
Stage 1: Build	35
Stage 2: Runtime	35
10. Bootstrap Script	36
The 9 Steps	36
Usage	36


11. Supporting Configuration Files	37
.env.example	37
.gitignore Highlights	37
.dockerignore	37


12. Glossary of Terms




