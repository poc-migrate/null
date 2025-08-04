data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}


data "terraform_remote_state" "infrastructure" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    bucket               = "datum-controlplane-infrastructure-tfstate-621074188511"
    key                  = "aws-shared-services-management/terraform.tfstate"
    workspace_key_prefix = "aws-shared-services-management"
    region               = "ap-southeast-1"
    dynamodb_table       = "datum-controlplane-infrastructure-tfstate"
    encrypt              = true

  }
}
