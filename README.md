
<a id="readme-top"></a>

<div align="center">
  
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![project_license][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

[![CI - Build and Scan Docker image (Automatic)](https://github.com/Mazharul419/ECS-Forge/actions/workflows/build_push_image.yaml/badge.svg)](https://github.com/Mazharul419/ECS-Forge/actions/workflows/build_push_image.yaml)
[![Lint Terragrunt Code (Automatic)](https://github.com/Mazharul419/ECS-Forge/actions/workflows/lint_terragrunt_code.yaml/badge.svg)](https://github.com/Mazharul419/ECS-Forge/actions/workflows/lint_terragrunt_code.yaml)
</div>



<!-- PROJECT LOGO -->

<div align="center">
  <a href="https://github.com/Mazharul419/ECS-Forge">
  </a>


<h3 align="center">ECS-Forge</h3>

<!-- <img width="569" height="500" alt="ECS Diagram Detailed - 25 04-Diagram Simple 25 04 drawio" src="https://github.com/user-attachments/assets/7beb5cfb-9ae9-44f6-b8de-142df7fdb773" /> -->

![alt text](<docs/ECS overall 1705.svg>)

  <p align="center">
    <br>
    <strong>An End-to-End deployment of Code-Server:
    <br>
    A browser-based Integrated Development Environnment hosted on ECS Fargate</strong>
    <br />
    <br>
    <a href="https://mazharul419.github.io/ECS-Forge/Architectural_Decisions/"> Key Architectural Decisions</a>
    &middot;
    <a href="https://mazharul419.github.io/ECS-Forge/Documentation/"><strong> In-depth Documentation</a>
    &middot;
    <a href="https://mazharul419.github.io/ECS-Forge/ecs-architecture-diagram.html">HD Architecture Diagram</a>
    <br>
    <a href="https://github.com/Mazharul419/ECS-Forge/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    &middot;
    <a href="https://github.com/Mazharul419/ECS-Forge/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>

### 👇 DETAILED DEMO 👇 ###
https://www.loom.com/share/748625955d4243fd9d828fcf824bd1c3

</div>
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This is the end-to-end deployment of the code-server application hosted on the AWS ECS Fargate service. Upon push to main, a Docker image of the application is automatically built and pushed to ECR - where via manual trigger in Github Actions, deployment to Dev and Prod environment (or both) takes place.

The application is hosted on AWS - hidden behind an application load balancer.

## Key Features
* 34% Cost reduction through use of VPC endpoints vs NAT Gateways
* 95% Docker image size reduction through multi-stage builds 
* Privacy-by-design via private subnet applications routing through Application Load Balancer (ALB)
* Enhanced security posture using short-lived GitHub OIDC credentials
* Image scanning secured via Anchore Grype, with failure upon critical vulnerabilities
* Adherence to Don't-Repeat-Yourself (DRY) principle through Terragrunt deployment
* Automatic linting of terragrunt code upon code change - ONLY correctly formatted and validated infra passes through
* Secure remote state through S3 native locking
* Intelligent FinOps strategy via resource tagging for cost management

<a href="https://github.com/Mazharul419/ECS-Forge/tree/main/architectural_decisions"><strong>»»» VIEW THE KEY ARCHITECTURAL DECISIONS HERE</strong></a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Built With

#### Application setup:

[![Linux][Linux]][Linux-url]
[![Docker][Docker]][Docker-url]
<br>
#### DNS/Cloud Infrastructure:

[![CloudFlare][CloudFlare]][CloudFlare-url] 
[![AWS][AWS]][AWS-url]
<br>
#### Infrastructure-As-Code:

[![Terraform][Terraform.io]][Terraform-url]
[![Terragrunt][Terragrunt.io]][Terragrunt-url]
[![HCL][HCL]][HCL-url]
<br>
#### Version Control and CI/CD:

[![Git][Git]][Git-url]
[![Github Actions][Github Actions]][Github Actions-url]
[![YAML][YAML]][YAML-url]
<br>

#### Additional Scripting Languages:

[![Bash][Bash]][Bash-url]
[![Python][Python]][Python-url]




<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Project Structure
```
├── mkdocs.yml
├── requirements.txt
├── docs
│   ├── Architectural_Decisions.md
│   ├── Documentation.md
│   ├── image-1.png
│   ├── image-2.png
│   ├── image.png
│   └── index.md
```

## Application
| Dev Environment |
|---|
| <img width="1913" height="999" alt="image" src="https://github.com/Mazharul419/ECS-Forge/blob/main/other/screenshots/devenv.png" />|

| Prod Environment |
|---|
| <img width="1918" height="995" alt="image" src="https://github.com/Mazharul419/ECS-Forge/blob/main/other/screenshots/prodenv.png" /> |

## Pipelines

### IaC Deployment

This pipeline is manually triggered - and deploys and destroys infrastructure using Terraform + Terragrunt. 

Environment selection: Dev or Prod* or All*

Terragrunt command to run: Plan or Apply

>*Requires manual approval

| deploy_environment.yaml |
|---|
| <img alt="image" src="https://github.com/Mazharul419/ECS-Forge/blob/main/other/screenshots/deploy_environment.png" /> |

| destroy_environment.yaml |
|---|
| <img alt="image" src="https://github.com/Mazharul419/ECS-Forge/blob/main/other/screenshots/destroy%20environment.png" /> |

### Image build and Scan

This pipeline auto-triggers upon push to main. Builds a Docker image and scans vulnerabilities using Grype:

| build_push_image.yaml |
|---|
| <img src="https://github.com/Mazharul419/ECS-Forge/blob/main/other/screenshots/build_push.png"/> |

An HTML vulnerability report is built and uploaded as an artifact, ready to be inspected by the dev:
| report.html |
|---|
| <img src="https://github.com/Mazharul419/ECS-Forge/blob/main/other/screenshots/vul_report.PNG"/> |


### IaC code linting 

This pipeline triggers upon push to main and change in the /infrastructure directory. This will initialise, validate, and format the Terragrunt configuration. Fails if any of these gates fail. 

> Even if the configuration is initialised and valid, if formatting is incorrect it will fail too.

| lint_terragrunt_code.yaml |
|---|
| <img src="https://github.com/Mazharul419/ECS-Forge/blob/main/other/screenshots/lint_terragrunt_code.PNG"/> |

### Manual Image deployment

This pipeline is manually triggered - and for a given sha-tagged image in ECR, will update the existing task definition and resulting ECS service to the new Image:

| deploy_image.yaml |
|---|
| <img src="https://github.com/Mazharul419/ECS-Forge/blob/main/other/screenshots/deploy_image.png"> |




<!-- GETTING STARTED -->
## Getting Started

This is how you can set up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

For the scripts annd infrastructure to run you need minimum the following:

* Terraform version 1.14.1
* Terragrunt 0.93.13**
* AWS cli 2.32.6 - should connect to AWS account with Admin credentials
* Python 3.12.3
* GNU bash 5.2.21
* Git 2.43.0
* Cloudflare account with Domain and Hosted zone

**this is strict requirement since terragrunt newer versions intoduced breaking changes to naming convention, code will not work otherwise

Please refer to the respective stack websites for instructions for installation - alternatively listed in "Built with" section.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/Mazharul419/ECS-Forge.git
   ```
2. Copy .env.example - rename to .env and set environment variables from Cloudflare tokens
   ```sh
   export TF_VAR_cloudflare_api_token="ABDCDEFGHIJKLMNOPQRSTUVWXYZ123456" > replace
   export CLOUDFLARE_ZONE_ID="a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6" > replace
   ```

   IMPORTANT - should be automatic but check to ensure .env is in your gitignore!
   
4. Run Boostrap script in `/infrastucture/bootstrap/bootstrap.sh`
   ```sh
   ./infrastucture/bootstrap/bootstrap.sh
   ```
   This creates an S3 bucket for the terraform state, an ECR Repo and Github Actions OIDC role for infrastructure to be deployed!
    
6. Go to Github actions and run the "Terragrunt Deploy" workflow:
   <img width="1883" height="400" alt="image" src="https://github.com/user-attachments/assets/ba53c3f1-d859-4b00-8481-da8bd1ffb10f" />


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

This project is useful for someone looking to go deep into learning Devops practices = amd understanding trade-offs and fundemental CI CD pipelines ensuring devs can ship code with ease. 

Additional screenshots, code examples and demos to be added as per roadmap below!


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [ ] Complete documentation for code 
- [ ] Add Autoscaling
- [ ] Minimal IAM permissions for OIDC role
- [ ] + Many more

See the [open issues](https://github.com/Mazharul419/ECS-Forge/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Top contributors:

<a href="https://github.com/Mazharul419/ECS-Forge/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Mazharul419/ECS-Forge" alt="contrib.rocks image" />
</a>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Mazharul Islam -  mazharulislam419@gmail.com.com

Project Link: [https://github.com/Mazharul419/ECS-Forge](https://github.com/Mazharul419/ECS-Forge)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

### CoderCo for providing the assignment, knowledge and community for me to complete this!
###  

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Mazharul419/ECS-Forge.svg?style=for-the-badge
[contributors-url]: https://github.com/Mazharul419/ECS-Forge/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Mazharul419/ECS-Forge.svg?style=for-the-badge
[forks-url]: https://github.com/Mazharul419/ECS-Forge/network/members
[stars-shield]: https://img.shields.io/github/stars/Mazharul419/ECS-Forge.svg?style=for-the-badge
[stars-url]: https://github.com/Mazharul419/ECS-Forge/stargazers
[issues-shield]: https://img.shields.io/github/issues/Mazharul419/ECS-Forge.svg?style=for-the-badge
[issues-url]: https://github.com/Mazharul419/ECS-Forge/issues
[license-shield]: https://img.shields.io/github/license/Mazharul419/ECS-Forge.svg?style=for-the-badge&cacheSeconds=0
[license-url]: https://github.com/Mazharul419/ECS-Forge/tree/main?tab=MIT-1-ov-file#MIT-1-ov-file
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/mazharul419
[product-screenshot]: images/screenshot.png
<!-- Shields.io badges. You can a comprehensive list with many more badges at: https://github.com/inttter/md-badges -->
[Terraform.io]: https://img.shields.io/badge/Terraform-844FBA?style=for-the-badge&logo=terraform&logoColor=fff
[Terraform-url]: https://developer.hashicorp.com/terraform
[Terragrunt.io]: https://img.shields.io/badge/Terragrunt-DDE072?style=for-the-badge&logo=terraform&logoColor=black
[Terragrunt-url]: https://terragrunt.com/
[Python]: https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white
[Python-url]: https://www.python.org/
[Bash]: https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white
[Bash-url]: https://www.gnu.org/software/bash/
[HCL]: https://img.shields.io/badge/HCL-844FBA?style=for-the-badge&logo=terraform&logoColor=fff 
[HCL-url]: https://developer.hashicorp.com/terraform/language
[YAML]: https://img.shields.io/badge/YAML-CB171E?style=for-the-badge&logo=yaml&logoColor=fff
[YAML-url]: https://yaml.org/
[Docker]: https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=fff
[Docker-url]: https://getbootstrap.com
[AWS]: https://custom-icon-badges.demolab.com/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=aws&logoColor=white
[AWS-url]: https://aws.amazon.com/
[CloudFlare]: https://img.shields.io/badge/Cloudflare-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white
[CloudFlare-url]: https://www.cloudflare.com/en-gb/
[Github Actions]: https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white 
[Github Actions-url]: https://github.com/features/actions
[Git]: https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=fff
[Git-url]: https://git-scm.com/
[Linux]: https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black
[Linux-url]: https://www.linux.org/
