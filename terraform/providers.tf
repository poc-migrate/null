provider "aws" {
  region = var.region
  assume_role {
    role_arn     = lookup(local.workspace_role_mapping, terraform.workspace)["role_arn"]
    session_name = coalesce(var.session_name, "BDO_AWS_INFRASTRUCTURE")
    external_id  = lookup(local.workspace_role_mapping, terraform.workspace)["external_id"]
  }
  default_tags {
    tags = {
      project  = "bdo"
      env      = terraform.workspace == "lz-common-services" ? "sandbox" : terraform.workspace
      ops-team = "Datum DevOps"
      poc      = "aws@datumhq.com"
      platform = "linux"
      repo     = "https://gitlab.common.datumhq.com/datumhq-consulting-vn/sandbox/bdo/bdo-aws-infrastructure"
    }
  }
}
