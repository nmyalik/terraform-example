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