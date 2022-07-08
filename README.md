# terraform-example

## Folders structure
### `Terraform`
This folder contains all terraform code
- `tfstate-backend`
<br />This folder contains terraform code, which creates S3 bucket for terraform state.

- `monolith`
<br />This folder contains terraform code with monolith structure splitted by env.

- `layers`
<br />This folder contains terraform code with different layers, which spliited by logical layers. Based on tf workspaces

### `Scripts`
This folder contains bash scripts.