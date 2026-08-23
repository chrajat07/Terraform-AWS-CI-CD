# Terraform AWS S3 Static Website with GitHub Actions CI/CD

## 📌 Project Overview

This project demonstrates how to provision an **AWS S3 static website using Terraform** and automate the deployment process using **GitHub Actions CI/CD**. Terraform manages the S3 infrastructure and remote state, while GitHub Actions uses AWS CLI to deploy the `index.html` file to the S3 bucket.

Terraform outputs are defined in `output.tf` to display important information about the deployed infrastructure, such as the S3 bucket name and website endpoint.

## 🏗️ Architecture

```text
Developer
    │
    │ git push
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├── Terraform Format
    ├── Terraform Init
    ├── Terraform Validate
    ├── Terraform Plan
    └── Terraform Apply
            │
            ▼
       AWS S3 Bucket
            │
            ├── index.html
            └── Terraform Outputs
                    │
                    ▼
             Static Website
```

## 🛠️ Technologies Used

* **Terraform** – Infrastructure as Code
* **AWS S3** – Static website hosting
* **AWS CLI** – Website file deployment
* **GitHub** – Source code management
* **GitHub Actions** – CI/CD automation
* **Terraform S3 Backend** – Remote Terraform state management
* **AWS IAM** – Authentication and access control

## 📂 Project Structure

```text
Terraform-AWS-CI-CD/
│
├── .github/
│   └── workflows/
│       └── s3.yml
│
├── index.html
├── s3.tf
├── terraform.tf
├── variable.tf
├── output.tf
├── .terraform.lock.hcl
├── .gitignore
└── README.md
```

## ⚙️ Terraform Infrastructure

Terraform is responsible for provisioning and configuring the S3 infrastructure.

The project includes:

* S3 bucket
* Static website configuration
* Public access configuration
* S3 bucket policy
* Terraform remote backend
* AWS provider configuration
* Terraform output values

The `output.tf` file defines output values that provide useful information after Terraform creates or updates the infrastructure. These outputs can include the S3 bucket name, website endpoint, and other resource details.

Example output values may be displayed after running:

```bash
terraform apply
```

or:

```bash
terraform output
```

Terraform does **not** manage the `index.html` file as an `aws_s3_object`.

The website file is deployed separately through the CI/CD workflow using AWS CLI.

## 🔄 CI/CD Workflow

The GitHub Actions workflow is triggered whenever code is pushed to the `main` branch.

### Workflow

```text
Git Push
   │
   ▼
Checkout Code
   │
   ▼
Setup Terraform
   │
   ▼
terraform fmt -check
   │
   ▼
terraform init
   │
   ▼
terraform validate
   │
   ▼
terraform plan
   │
   ▼
terraform apply
   │
   ├── Provision AWS infrastructure
   └── Display Terraform outputs
            │
            ▼
Upload index.html
   │
   ▼
S3 Static Website
```

## 🚀 Deployment Process

### 1. Clone the repository

```bash
git clone <repository-url>
cd Terraform-AWS-CI-CD
```

### 2. Initialize Terraform

```bash
terraform init
```

This downloads the required Terraform providers and initializes the configured S3 backend.

### 3. Format Terraform files

```bash
terraform fmt
```

### 4. Validate the configuration

```bash
terraform validate
```

### 5. Review the Terraform plan

```bash
terraform plan
```

### 6. Apply the infrastructure

```bash
terraform apply
```

After the infrastructure is created, Terraform displays the configured output values. These outputs can be viewed again using:

```bash
terraform output
```

After the infrastructure is created, GitHub Actions deploys the latest `index.html` file to the S3 bucket.

## 🔐 AWS Authentication

GitHub Actions uses AWS credentials stored as **GitHub Actions Secrets**.

Required secrets:

```text
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

These credentials are used by Terraform and AWS CLI to interact with AWS.

> For a production environment, GitHub OIDC with an AWS IAM role is recommended instead of long-lived access keys.

## 🗄️ Terraform Remote State

Terraform state is stored remotely in an S3 backend instead of keeping the state file only on the local machine.

Example:

```hcl
terraform {
  backend "s3" {
    bucket       = "terraform-state-bucket"
    key          = "s3-website/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
```

The remote state allows Terraform to maintain a consistent view of the infrastructure when Terraform is executed from GitHub Actions or another machine.

## 📤 Terraform Outputs

The `output.tf` file is used to expose important information about the deployed AWS resources.

Typical outputs may include:

* S3 bucket name
* S3 static website endpoint
* AWS region
* Other resource attributes

To display the available outputs, run:

```bash
terraform output
```

To display a specific output, run:

```bash
terraform output <output-name>
```

Terraform outputs are also shown after a successful `terraform apply` operation and can help identify the deployed website endpoint.

## 🌐 Static Website

The S3 bucket is configured for static website hosting with:

```text
index.html
```

as the index document.

The website files are uploaded using AWS CLI during the GitHub Actions deployment.

The website endpoint can be retrieved from the Terraform outputs after deployment.

## 🎯 Key Achievements

* Automated **AWS S3 static website infrastructure provisioning using Terraform**, including bucket configuration, website hosting, public access, bucket policies, remote state management, and output values.
* Added an `output.tf` file to expose useful information about the deployed S3 infrastructure.
* Implemented **GitHub Actions CI/CD** to validate, plan, and deploy infrastructure and **`index.html`** to S3 using AWS CLI on every push to `main`.
* Separated **Infrastructure as Code** from **application file deployment**, providing a cleaner Terraform and CI/CD architecture.

## 📚 What I Learned

Through this project, I gained hands-on experience with:

* Terraform Infrastructure as Code
* Terraform providers and state
* Terraform S3 backend
* Terraform output values
* Terraform resource dependencies
* AWS S3 static website hosting
* S3 bucket policies
* S3 Block Public Access
* AWS CLI
* Git and GitHub
* GitHub Actions
* CI/CD pipelines
* Automated cloud deployments

## 🔮 Future Improvements

Planned improvements for a production-ready version:

* Replace AWS access keys with **GitHub Actions OIDC**
* Add separate **CI and CD workflows**
* Add Pull Request based Terraform planning
* Add manual approval before production deployment
* Add Terraform security scanning using tools such as **Checkov** or **Trivy**
* Use **S3 + CloudFront + Origin Access Control** instead of a publicly accessible S3 bucket
* Introduce reusable Terraform modules
* Add separate `dev` and `prod` environments

---

## 👨‍💻 Author

**Rajat Choudhary**

Cloud Operations Engineer | AWS | Azure | Terraform | Automation | CI/CD
