variable "region" {
  type        = string
  description = "Active region"
  default     = "us-east-2" ## N. Virginia
}

variable "session_name" {
  type        = string
  description = "(Optional) Session name to use when assuming the role."
  default     = "BDO_AWS_INFRASTRUCTURE"
}

variable "prefix" {
  type        = string
  description = "(optional) prefix name for resources"
  default     = "bdo" # internal
}

variable "env" {
  type    = string
  default = ""
}

############################################################
#                 RDS Postgresql                           #
############################################################
variable "create_db" {
  description = "Create database oracle or not"
  type        = bool
  default     = true
}
## DB subnet group
variable "postgresql_num_of_subnet_ids" {
  description = "Number of subnet ids"
  type        = number
}
## DB parameter group
variable "postgresql_family" {
  description = "Family version of postgresql"
  type        = string
}
## DB instance
variable "postgresql_engine_version" {
  description = "Engine version of postgresql"
  type        = string
}
variable "postgresql_deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}
variable "postgresql_dbname" {
  description = "The db name of rds"
  type        = string
  default     = null
}
variable "postgresql_username" {
  description = "The username of rds"
  type        = string
  default     = null
}
variable "postgresql_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = null
}
variable "postgresql_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter"
  type        = string
  default     = null
}
variable "postgresql_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = null
}
variable "postgresql_max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}
variable "postgres_additional_parameters" {
  type    = list(any)
  default = []
}
# variable "postgresql_iops" {
#   description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' or `gp3`. See `notes` for limitations regarding this variable for `gp3`"
#   type        = number
#   default     = null
# }
# variable "postgresql_storage_throughput" {
#   description = "Storage throughput value for the DB instance. See `notes` for limitations regarding this variable for `gp3`"
#   type        = number
#   default     = null
# }
variable "postgresql_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}
variable "postgresql_allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = false
}
variable "postgresql_auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}
## Final snapshot before delete db
# variable "postgresql_final_snapshot_identifier_prefix" {
#   description = "The name which is prefixed to the final snapshot on cluster destroy"
#   type        = string
#   default     = "final"
# }
## Maintenance
variable "postgresql_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = null
}
## Backup
variable "postgresql_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = null
}
variable "postgresql_backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = null
}
variable "postgresql_enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = []
}
variable "iam_database_authentication_enabled" {
  type    = bool
  default = true
}

variable "ca_cert_identifier" {
  type    = string
  default = "rds-ca-rsa2048-g1"
}
variable "postgresql_additional_tags" {
  type    = map(string)
  default = {}
}

###############################################
# SSM Parameter store
###############################################
variable "create" {
  type    = bool
  default = true

}

variable "parameter_read" {
  type        = list(string)
  description = "List of parameters to read from SSM. These must already exist otherwise an error is returned. Can be used with `parameter_write` as long as the parameters are different."
  default     = []
}

variable "parameter_write" {
  type        = list(map(string))
  description = "List of maps with the parameter values to write to SSM Parameter Store"
  default     = []
}

variable "parameter_write_defaults" {
  type        = map(any)
  description = "Parameter write default settings"
  default = {
    value           = "temp"
    description     = null
    type            = "SecureString"
    tier            = "Standard"
    overwrite       = "false"
    allowed_pattern = null
    data_type       = "text"
  }
}

variable "ignore_value_changes" {
  type        = bool
  description = "Whether to ignore future external changes in paramater values"
  default     = false
}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"
  type        = number
  default     = 15
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled"
  type        = string
  default     = "kong-rds-monitoring-role"
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = bool
  default     = true
}

variable "rds_schedule_tags" {
  type    = map(any)
  default = {}
}
###############################################
# SSM Parameter store
###############################################
variable "kms_key_id" {
  description = "The ARN for the KMS encryption key"
  type        = string
  default     = null
}

################################################################################
## AWS IAM Roles
################################################################################
variable "iam_roles" {
  type    = list(string)
  default = []
}
variable "iam_policies" {
  type    = list(string)
  default = []
}

variable "role_prefix" {
  type     = string
  nullable = true
}

variable "role_suffix" {
  type     = string
  nullable = true
}

variable "identity_providers" {
  type    = any
  default = {}
}
variable "exclude_role_creation_based_on_iam_policies" {
  type    = list(string)
  default = []
}
