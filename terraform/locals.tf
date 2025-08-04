resource "time_static" "current_date" {}


locals {
  prefix                        = var.prefix
  suffix                        = terraform.workspace
  account_id                    = data.aws_caller_identity.current.account_id
  workspace_role_mapping        = module.aws_accounts.role_mappings["root_roles_mapping"]
  current_account_network_infos = module.aws_accounts.account_network_infos[local.account_id][var.region]
  db_identifier                 = "${local.prefix}-keephq-${terraform.workspace}-db-postgresql-rds"
  common_tags = merge(
    {
      "managed" = "Terraform"
    }
  )
}
