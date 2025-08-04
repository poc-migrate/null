module "keephq_sg" {
  source = "git@bitbucket.org:datumhq/aws-securitygroup-module.git"

  name        = "${local.prefix}-keephq-sg"
  description = "KeepHQ Security group"
  vpc_id      = local.current_account_network_infos["selected_vpc_id"]

  #tags = {
  #  Department = ""
}

module "keephq_db" {
  source = "git@bitbucket.org:datumhq/aws-rds-module.git"

  create_db_subnet_group      = var.create_db
  create_db_instance          = var.create_db
  create_db_parameter_group   = var.create_db
  create_random_password      = var.create_db
  create_cloudwatch_log_group = false
  ## DB subnet group
  db_subnet_group_name        = "${local.prefix}-keephq-${terraform.workspace}-db-subnet-group-rds"
  db_subnet_group_description = "${local.prefix}-keephq-${terraform.workspace}-db-subnet-group-rds"
  subnet_ids                  = slice(local.current_account_network_infos.selected_data_subnets, 0, var.postgresql_num_of_subnet_ids)
  ## DB parameter group
  parameter_group_name        = "${local.prefix}-keephq-${terraform.workspace}-db-parameter-group-rds"
  parameter_group_description = "${local.prefix}-keephq-${terraform.workspace}-db-parameter-group-rds"
  family                      = var.postgresql_family
  parameters = concat([
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ], var.postgres_additional_parameters)
  ## DB instance
  identifier                          = local.db_identifier
  engine                              = "postgres"
  engine_version                      = var.postgresql_engine_version
  instance_class                      = var.postgresql_instance_class
  storage_type                        = var.postgresql_storage_type
  storage_encrypted                   = true
  allocated_storage                   = var.postgresql_allocated_storage
  max_allocated_storage               = var.postgresql_max_allocated_storage # scaling storage
  kms_key_id                          = var.kms_key_id
  db_name                             = var.postgresql_dbname
  username                            = var.postgresql_username
  port                                = 5432
  multi_az                            = var.postgresql_multi_az
  vpc_security_group_ids              = [module.keephq_sg.security_group_id]
  deletion_protection                 = var.postgresql_deletion_protection
  allow_major_version_upgrade         = var.postgresql_allow_major_version_upgrade
  auto_minor_version_upgrade          = var.postgresql_auto_minor_version_upgrade
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  ## Final snapshot before delete db
  skip_final_snapshot   = false
  copy_tags_to_snapshot = true
  #final_snapshot_identifier_prefix = var.postgresql_final_snapshot_identifier_prefix
  ## Maintenance
  maintenance_window = var.postgresql_maintenance_window
  ## Backup
  backup_window           = var.postgresql_backup_window
  backup_retention_period = var.postgresql_backup_retention_period
  ## Logs
  enabled_cloudwatch_logs_exports = var.postgresql_enabled_cloudwatch_logs_exports
  ## Monitoring
  # Performance insights disabled
  performance_insights_enabled = var.performance_insights_enabled
  # Enhanced monitoring disabled
  monitoring_interval    = var.monitoring_interval
  create_monitoring_role = var.create_monitoring_role
  monitoring_role_name   = "${local.prefix}-${terraform.workspace}-${var.monitoring_role_name}"
  # apply_immediately      = true
  # Certificate Authority (CA)
  ca_cert_identifier = var.ca_cert_identifier
  ## Tags
  # tags = merge(local.common_tags, var.rds_schedule_tags, var.postgresql_additional_tags)
}

# add credentias to secret manager
module "keephq-rds-sec" {
  source        = "git@bitbucket.org:datumhq/aws-secret-manager-module.git"
  create_secret = var.create_db
  secrets = {
    "/${local.prefix}/${terraform.workspace}/rds/postgresql/keephq-sec" = {
      description = "${terraform.workspace}/rds/postgresql/keephq-sec"
      secret_key_value = {
        username             = module.keephq_db.db_instance_username
        password             = module.keephq_db.db_instance_password
        engine               = "postgres"
        host                 = module.keephq_db.db_instance_address
        port                 = module.keephq_db.db_instance_port
        dbname               = module.keephq_db.db_instance_name
        dbInstanceIdentifier = local.db_identifier
      }
      recovery_window_in_days = 7
      kms_key_id              = var.kms_key_id
    }
  }
  # tags = local.common_tags
}

