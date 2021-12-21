terraform {
  required_version = "~> 1.0.11"
  backend "remote" {
    organization = "PublicSector-ATARC"
    workspaces {
      name = "fse-tf-atarc-aws-vpn"
    }
  }
}
