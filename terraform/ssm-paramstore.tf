module "secrets_paramstore" {
  source          = "git@bitbucket.org:datumhq/aws-ssm-parameter-store-module.git"
  parameter_write = var.parameter_write
  parameter_read  = var.parameter_read
  # kms_arn                  = module.kms.key_arn
  parameter_write_defaults = var.parameter_write_defaults
  ignore_value_changes     = true
}
