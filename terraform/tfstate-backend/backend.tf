terraform {
  backend "s3" {
    region = "eu-central-1"
    bucket = "development-terraform-state-365scores"
    key    = "terraform.tfstate"
  }
}
