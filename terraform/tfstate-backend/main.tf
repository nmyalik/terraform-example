module "terraform_state_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "0.38.1"

  namespace  = var.env
  name       = "terraform"
  attributes = ["state", "365scores"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = false
  dynamodb_enabled                   = false
}
