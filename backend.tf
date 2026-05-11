# Copyright IBM Corp. 2021, 2026

terraform {
  required_version = "~> 1.0.11"
  backend "remote" {
    organization = "PublicSector-ATARC"
    workspaces {
      name = "fse-tf-atarc-aws-vpn"
    }
  }
}
