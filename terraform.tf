terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "rajat-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
}