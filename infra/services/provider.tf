terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    region = lookup(var.aws_credentials,"aws_region")
    access_key = lookup(var.aws_credentials,"aws_access_key")
    secret_key = lookup(var.aws_credentials,"aws_secret_key")
}