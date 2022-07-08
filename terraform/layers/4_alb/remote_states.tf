data "terraform_remote_state" "dns" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    bucket  = "development-terraform-state-365scores"
    key     = "dns.tfstate"
    region  = "eu-central-1"
    encrypt = "true"
  }
}

data "terraform_remote_state" "sg" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    bucket  = "development-terraform-state-365scores"
    key     = "sg.tfstate"
    region  = "eu-central-1"
    encrypt = "true"
  }
}

data "terraform_remote_state" "vpc" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    bucket  = "development-terraform-state-365scores"
    key     = "vpc.tfstate"
    region  = "eu-central-1"
    encrypt = "true"
  }
}