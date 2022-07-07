data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "development-terraform-state-365scores"
    key     = "vpc.tfstate"
    region  = "eu-central-1"
  }
}