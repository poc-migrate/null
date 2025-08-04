region = "ap-southeast-1"
prefix = "bdo"

############################################################
#                 RDS Postgresql                           #
############################################################
##### RDS 
## DB subnet group
postgresql_num_of_subnet_ids = 2
## DB instance
postgresql_engine_version      = "15"
postgresql_family              = "postgres15"
postgresql_deletion_protection = true
postgresql_dbname              = "keephq" # align with the application
postgresql_username            = "dbadmin"
postgresql_instance_class      = "db.t3.small"
postgresql_storage_type        = "gp3"
postgresql_allocated_storage   = 50
postgresql_multi_az            = false
postgres_additional_parameters = [{
  name  = "rds.force_ssl"
  value = "1"
}]
## Monitoring
performance_insights_enabled = true
## Final snapshot before delete db
# postgresql_final_snapshot_identifier_prefix = "final"
## Maintenance
postgresql_maintenance_window = "sat:15:00-sat:16:00"
## Backup
#postgresql_backup_window           = "02:00-04:00"
postgresql_backup_retention_period = 7
## Logs
postgresql_enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
rds_schedule_tags = {
  "auto:schedule:custom"  = "06:00-04:00"
  "auto:schedule:weekday" = "false"
  "auto:schedule:bypass"  = "true"
}
postgresql_additional_tags = {
  "env"               = "prod"
  "systemapplication" = "Datum"
  "projectname"       = "aws-infrastructure"
  "level"             = "level1"
  "segment"           = "lz-common-services"
}

monitoring_role_name = "keephq-rds-monitoring-role"
###############################################
# SSM Parameter store
###############################################
parameter_write = [
  {
    name            = "/bdo/private/secret/keephq/password"
    value           = "temp"
    type            = "SecureString"
    overwrite       = "true"
    data_type       = "text"
    allowed_pattern = null
    tier            = "Standard"
  },
  {
    name            = "/bdo/eks/keephq/secret/azure-activedirectory-v2"
    value           = "temp"
    type            = "SecureString"
    overwrite       = "true"
    data_type       = "text"
    allowed_pattern = null
    tier            = "Standard"
  },
  {
    name            = "/bdo/rds/cert/ap-southeast-1/cert-bundle.pem"
    value           = "temp"
    type            = "SecureString"
    overwrite       = "true"
    data_type       = "text"
    allowed_pattern = null
    tier            = "Advanced"
  },
  {
    name            = "/bdo/keephq/configuration"
    value           = "temp"
    type            = "SecureString"
    overwrite       = "true"
    data_type       = "text"
    allowed_pattern = null
    tier            = "Advanced"
  }
]

###############################################
# IAM Roles/Policies
###############################################

role_prefix = ""
role_suffix = ""
iam_roles = [ # for global/ resources, no need to specify here
]
iam_policies = [ # for global/ resources, no need to specify here
]
