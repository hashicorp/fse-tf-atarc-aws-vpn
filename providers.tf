terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.88.1"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Owner       = "Daniel Fedick"
      Purpose     = "ATARC DEMO"
      Terraform   = "true"
      Environment = "development"
    }
  }

}
