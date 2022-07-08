terraform {
  backend "s3" {
    bucket  = "development-terraform-state-365scores"
    key     = "monolith/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = "true"
  }
}
