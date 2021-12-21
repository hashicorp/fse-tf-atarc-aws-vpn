data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "PublicSector-ATARC"
    workspaces = {
      name = "fse-tf-atarc-aws-vpc"
    }
  }
}

data "terraform_remote_state" "vgw" {
  backend = "remote"

  config = {
    organization = "PublicSector-ATARC"
    workspaces = {
      name = "fse-tf-atarc-azure-vgw"
    }
  }
}

data "terraform_remote_state" "vnet" {
  backend = "remote"

  config = {
    organization = "PublicSector-ATARC"
    workspaces = {
      name = "fse-tf-atarc-azure-vnet"
    }
  }
}