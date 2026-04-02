# Intro

This is documentation for the ECS-Forge repo - it contains docs related to all the code set up for this project.

## Table of Contents
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#traffic-flow-explained">Traffic flow explained</a>
      <ul>
        <li><a href="#access-to-website">Access to website</a></li>
        <li><a href="#load-balancer-and-remaining">Load balancer and remaining</a></li>
      </ul>
    </li>
    <li>
      <a href="#technology-stack-explained">Technology stack explained</a>
      <ul>
        <li><a href="#infrastructure-as-code-tools">Infrastructure-as-code tools</a></li>
          <ul>
          <li><a href="#terraform">Terraform</a></li>
          <li><a href="#terragrunt">Terragrunt</a></li>
          <li><a href="#aws-services-used">AWS services used</a></li>
          </ul>
      </ul>
    </li>
    <li>
      <a href="#project-structure">Project Structure</a>
      <ul>
        <li><a href="#overview">Overview</a></li>
          <ul>
          <li><a href="#dockerfile,-license,-readme.md,-and-app">Dockerfile, LICENSE, README.md, and App</a></li>
          <li><a href="#architecture---decisions.md-file-and-documentation---readme.md-file">Architecture - decisions.md file and Documentation - README.md file</a></li>
          <li><a href="#infrastructure-directory">Infrastructure directory</a>
            <ul>
            <li><a href="#backend,-provider.tf-files">Backend, provider.tf files</a></li>
            <li><a href="#infrastructure---live-directory">Infrastructure - live directory</a></li>
            <li><a href="#[]">[]</a></li>
            </ul>
          </li>
          </ul>
      </ul>
    </li>
  </ol>
</details>

# Traffic Flow Explained

## Access to website

![alt text](image.png)


To access the live application in production environment, the user types in ***tm.mazharulislam.dev***(or ***tm-dev.mazharulislam.dev*** if accessing development environment).

A DNS (Domain Name System) query takes place - the client sends out tm.mazharulislam.dev and receives the IP address of the public-facing Application Load Balancer (ALB) allowing it to connect to the application hosted in AWS.

![alt text](image-1.png)


Assuming there is no cache stored at any stage - [the following](https://www.cloudflare.com/en-gb/learning/dns/what-is-dns/) will happen:

1. User types in "tm.mazharulislam.dev" - the client checks locally to see if the IP address is cached - within it's browser, or the OS

2. The query travels into the Internet and is received by a DNS resolver

3. The root server responds with the address of a Top Level Domain (TLD) DNS server .dev

4. The resolver then makes a request to the TLD server carrying .dev domain which responds with the IP address of the domain’s nameserver mazharulislam.dev

5. The resolver sends a query to the domain’s nameserver - since a subdomain **tm** is present there is an [additional nameserver](https://www.cloudflare.com/en-gb/learning/dns/what-is-dns/) which holds the CNAME record

6. The [CNAME](https://developers.cloudflare.com/dns/manage-dns-records/reference/dns-record-types/) is mapped to the Application Load Balancer (ALB) DNS name which is returned to the resolver from the nameserver

7. The authoritative name server responds to the DNS resolver with the CNAME record which includes the DNS name of the load balancer*

8. This record is forwarded to the client

9. Client makes a new query for the ALB CNAME

10. The resolver forwards to amazonaws.com domain where the A record is hosted

11. A record containing the [IP addresses of the ALB nodes](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html) is returned to DNS resolver

12. DNS resolver finally returns the IP address of the ALB, allowing the client to send a HTTP request in order to connect to the code-server application



*If the apex zone mazharulislam.dev was used instead (by replacing **tm** with **@**), Cloudflare can return the ALB IP address via a process called [CNAME flattening](https://developers.cloudflare.com/dns/cname-flattening/)(see also [Flattening diagram](https://developers.cloudflare.com/dns/cname-flattening/cname-flattening-diagram/))


# Load Balancer and remaining

Use this section to explain flow from ALB to tasks in private subnet

Also explain how applications can access AWS services privately


# Technology Stack Explained

## Infrastructure as Code Tools

## Terraform

## Terragrunt

## AWS Services Used

# Project Structure

## Overview

```
.
├── Dockerfile
├── LICENSE
├── README.md
├── app
├── architecture
│   └── decisions.md
├── documentation
│   └── README.md
├── infrastructure
│   ├── backend.tf
│   ├── bootstrap
│   │   ├── ReadMe.md
│   │   ├── bootstrap.sh
│   │   └── destroy.sh
│   ├── live
│   │   ├── _env
│   │   │   └── common.hcl
│   │   ├── dev
│   │   │   ├── acm
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── alb
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── dns
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── ecs
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── env.hcl
│   │   │   ├── security-groups
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── vpc
│   │   │   │   └── terragrunt.hcl
│   │   │   └── vpc-endpoints
│   │   │       └── terragrunt.hcl
│   │   ├── global
│   │   │   ├── ecr
│   │   │   │   └── terragrunt.hcl
│   │   │   └── oidc
│   │   │       └── terragrunt.hcl
│   │   └── prod
│   │       ├── acm
│   │       │   └── terragrunt.hcl
│   │       ├── alb
│   │       │   └── terragrunt.hcl
│   │       ├── dns
│   │       │   └── terragrunt.hcl
│   │       ├── ecs
│   │       │   └── terragrunt.hcl
│   │       ├── env.hcl
│   │       ├── security-groups
│   │       │   └── terragrunt.hcl
│   │       ├── vpc
│   │       │   └── terragrunt.hcl
│   │       └── vpc-endpoints
│   │           └── terragrunt.hcl
│   ├── modules
│   │   ├── acm
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── alb
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── dns
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── ecr
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── ecs
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── oidc
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── security-groups
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── vpc
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── vpc-endpoints
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── provider.tf
│   └── terragrunt.hcl
└── other
    ├── both.tf
    ├── createpolicy.tf
    └── deletepolicy.tf
```

## Structure Explained

### Dockerfile, LICENSE, README.md, and App

```
├── Dockerfile
├── LICENSE
├── README.md
├── app
```

According to [Docker docs](https://docs.docker.com/reference/dockerfile/) the Dockerfile is a text file that contains all the commands that a user would run on a command line that tells Docker to build the image.

The ReadME.md file is for any person visiting the repo to understand at a high level what the project does and how they can set this up for themselves.

The LICENSE.txt file specifies how the repo can be distributed and used.

The app directory contains the application itself - though it is not used in the Dockerfile (due to issues with git submodules not pulling the application properly)

### Architecture - decisions.md file and Documentation - README.md file

```
├── architecture
│   └── decisions.md
├── documentation
│   └── README.md
```

The decisions.md file in the architecture directory outline the key architectural decisions made in the project. This file communicates IMPACT as opposed to details in the next file.

The README.md file (this file) in the documentation directory is documentation for the ECS-Forge repo - it contains docs related to all the code set up for this project.

### Infrastructure directory

```
└── infrastructure
    ├── backend.tf
    ├── bootstrap
    ├── live
    ├── modules
    ├── provider.tf
    └── terragrunt.hcl
```
This directory contains EVERYTHING related to the infrastructure required to deploy the application.

#### Backend, provider.tf files
```
└── infrastructure
    ├── backend.tf
    .
    .
    .
    ├── provider.tf
```

Terragrunt automatically generates these files in order to tell terraform where the S3 bucket is stored and which providers to use respectively. They are generated every run and can be safely deleted.

#### Infrastructure - live directory

```
│   ├── live
│   │   ├── _env
│   │   │   └── common.hcl
│   │   ├── dev
│   │   │   ├── acm
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── alb
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── dns
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── ecs
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── env.hcl
│   │   │   ├── security-groups
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── vpc
│   │   │   │   └── terragrunt.hcl
│   │   │   └── vpc-endpoints
│   │   │       └── terragrunt.hcl
│   │   ├── global
│   │   │   ├── ecr
│   │   │   │   └── terragrunt.hcl
│   │   │   └── oidc
│   │   │       └── terragrunt.hcl
│   │   └── prod
│   │       ├── acm
│   │       │   └── terragrunt.hcl
│   │       ├── alb
│   │       │   └── terragrunt.hcl
│   │       ├── dns
│   │       │   └── terragrunt.hcl
│   │       ├── ecs
│   │       │   └── terragrunt.hcl
│   │       ├── env.hcl
│   │       ├── security-groups
│   │       │   └── terragrunt.hcl
│   │       ├── vpc
│   │       │   └── terragrunt.hcl
│   │       └── vpc-endpoints
│   │           └── terragrunt.hcl
```

This directory contains the live Terragrunt configuration of the:

- global infra: Modules that bootstrap the dev and prod environments
- dev infra: Modules for development enviromnent
- prod infra: Modules for production environment
- common.hcl: This a file containing common values between the above directories

These directories contain further directories representing [single instances of infrastructure](https://docs.terragrunt.com/getting-started/terminology#unit) managed by Terragrunt - represented by the presence of terragrunt.hcl files which define the [Terragrunt configuration](https://docs.terragrunt.com/reference/hcl/)

This the HOW and WHERE - which environment, values, and where to store state.

#### Infrastructure - modules directory

```
│   ├── infrastructure
    │   .
    │   .
    │   .
    │   ├── modules
    │   │   ├── acm
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   └── variables.tf
    │   │   ├── alb
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   └── variables.tf
    │   │   ├── dns
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   └── variables.tf
    │   │   ├── ecr
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   └── variables.tf
    │   │   ├── ecs
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   └── variables.tf
    │   │   ├── oidc
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   └── variables.tf
    │   │   ├── security-groups
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   └── variables.tf
    │   │   ├── vpc
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   └── variables.tf
    │   │   └── vpc-endpoints
    │   │       ├── main.tf
    │   │       ├── outputs.tf
    │   │       └── variables.tf
```

This contains the reusable terraform modules required for deploying infrastructure. The units call the variables at runtime. This is the WHAT - the actual AWS resources.

# DEEP DIVE
## Root Configuration (terragrunt.hcl)

### File Location

```
└── infrastructure
    ├── backend.tf
    ├── bootstrap
    .
    .
    .
    └── terragrunt.hcl
```
This file is located within the root of my infrastructure directory (directly inside it - not any further in). This is because it holds configuration common to ALL modules.

### Locals Block

```
locals {
  project_name = "ecs-project"
  aws_region   = "eu-west-2"
  domain_name  = "mazharulislam.dev"
  account_id   = get_aws_account_id()
  bucket_name  = "${local.project_name}-terraform-state-${local.account_id}-${local.aws_region}"
  environment = element(split("/", path_relative_to_include()), 1)
}
```

This block defines values that I will use [elsewhere in my configuration](https://docs.terragrunt.com/reference/hcl/blocks/#:~:text=The%20locals%20block%20is%20used%20to%20define%20aliases%20for%20Terragrunt%20expressions%20that%20can%20be%20referenced%20elsewhere%20in%20configuration.). These are values are REFERENCED by Terragrunt in almost every single unit that is run.

When they call terraform modules, they POPULATE the empty values set for variables (variables.tf).



### Remote State Block

```
remote_state {
  backend = "s3"
  
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  
  config = {
    bucket       = local.bucket_name
    key          = "${path_relative_to_include()}/terraform.tfstate"
    region       = local.aws_region
    encrypt      = true
    use_lockfile = true
  }
}
```

This block is used to [configure the remote state configuration](https://docs.terragrunt.com/reference/hcl/blocks/#:~:text=The%20remote_state%20block%20is%20used%20to%20configure%20how%20Terragrunt%20will%20set%20up%20the%20remote%20state%20configuration%20of%20your%20OpenTofu/Terraform%20code.) for terraform.

With `backend = s3` - the backend is defined as Amazon Web Service's (AWS) Simple Storage Solution (S3) - this is highly available cloud storage which provides remote storage for the terraform state. Contrasting to storing locally this is much more reliable since AWS manages this specifically and [provides 99.99% availability](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DataDurability.html) for objects stored in it over a year.

The `generate` block requests terragrunt to [generate a `backend.tf` in the working directory](https://oneuptime.com/blog/post/2026-02-23-how-to-use-the-generate-block-in-terragrunt/view#:~:text=creates%20provider.tf%20in%20the%20working%20directory%20with%20the%20specified%20contents.) with the specified configuration.

`path = "backend.tf"` provides the path where the backend.tf file is generated - set to the same directory as this file.

`if_exists = "overwrite_terragrunt"` tells Terragrunt to overwrite TERRAGRUNT GENERATED backend.tf file if it already exists. This is not an issue mostly, however this prevents overwriting a human-written backend.tf file if that was created.

ADR-001: Remote S3 backend

Generate Provider Block


6. Terraform Modules
6.1 VPC Module
Data Source: Availability Zones
VPC Resourcs
Public Subnets
Private Subnets
Public Route Table
Private Route Tables
Internet Gateway
6.2 Security Groups Module
ALB Security Group
ECS Security Group
VPC Endpoints Security Group
6.3 VPC Endpoints Module
Cost Comparison: NAT Gateway vs VPC Endpoints
S3 Gateway Endpoint (FREE)
ECR API Endpoint
ECR DKR Endpoint
CloudWatch Logs Endpoint
6.4 ACM (Certificate) Module
Certificate Request
DNS Validation Record
Certificate Validation
6.5 ALB (Application Load Balancer) Module
Load Balancer
Target Group
HTTPS Listener
HTTP Listener (Redirect)
6.6 DNS Module
6.7 ECS Module
ECS Concepts
Cluster
CloudWatch Log Group
Task Execution Role
Task Definition
ECS Service
6.8 ECR Module
6.9 OIDC Module
Why OIDC Instead of Access Keys?


7. Live Environment Configurations
Dev Environment (env.hcl)
Prod Environment (env.hcl)
Terragrunt Dependencies


8. CI/CD Pipelines (GitHub Actions)
Key CI/CD Sections
OIDC Permissions
AWS Authentication
Task Definition Update


9. Dockerfile Explained
Stage 1: Build
Stage 2: Runtime

10. Bootstrap Script
The 9 Steps
Usage


11. Supporting Configuration Files	37
.env.example
.gitignore Highlights
.dockerignore


12. Glossary of Terms




