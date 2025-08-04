<!-- BEGIN_TF_DOCS -->

BDO AWS Infrastructure

## Tools you may need

```
tfenv
aws cli
```

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | ~> 1.9.5 |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 5.64.0 |
| <a name="requirement_helm"></a> [helm](#requirement_helm) | ~> 2.16.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement_kubernetes) | ~> 2.33.0 |
| <a name="requirement_time"></a> [time](#requirement_time) | ~> 0.12.0 |

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider_aws) | 5.64.0 |
| <a name="provider_terraform"></a> [terraform](#provider_terraform) | n/a |
| <a name="provider_time"></a> [time](#provider_time) | 0.12.1 |

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_accounts"></a> [aws_accounts](#module_aws_accounts) | git@bitbucket.org:datumhq/aws-accounts.git | n/a |
| <a name="module_keephq-rds-sec"></a> [keephq-rds-sec](#module_keephq-rds-sec) | git@bitbucket.org:datumhq/aws-secret-manager-module.git | n/a |
| <a name="module_keephq_db"></a> [keephq_db](#module_keephq_db) | git@bitbucket.org:datumhq/aws-rds-module.git | n/a |
| <a name="module_keephq_sg"></a> [keephq_sg](#module_keephq_sg) | git@bitbucket.org:datumhq/aws-securitygroup-module.git | n/a |
| <a name="module_secrets_paramstore"></a> [secrets_paramstore](#module_secrets_paramstore) | git@bitbucket.org:datumhq/aws-ssm-parameter-store-module.git | n/a |

#### Resources

| Name | Type |
|------|------|
| [aws_iam_policy.global_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.master_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [time_static.current_date](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [terraform_remote_state.infrastructure](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_postgresql_engine_version"></a> [postgresql_engine_version](#input_postgresql_engine_version) | Engine version of postgresql | `string` | n/a | yes |
| <a name="input_postgresql_family"></a> [postgresql_family](#input_postgresql_family) | Family version of postgresql | `string` | n/a | yes |
| <a name="input_postgresql_num_of_subnet_ids"></a> [postgresql_num_of_subnet_ids](#input_postgresql_num_of_subnet_ids) | Number of subnet ids | `number` | n/a | yes |
| <a name="input_role_prefix"></a> [role_prefix](#input_role_prefix) | n/a | `string` | n/a | yes |
| <a name="input_role_suffix"></a> [role_suffix](#input_role_suffix) | n/a | `string` | n/a | yes |
| <a name="input_ca_cert_identifier"></a> [ca_cert_identifier](#input_ca_cert_identifier) | n/a | `string` | `"rds-ca-rsa2048-g1"` | no |
| <a name="input_create"></a> [create](#input_create) | ############################################## SSM Parameter store ############################################## | `bool` | `true` | no |
| <a name="input_create_db"></a> [create_db](#input_create_db) | Create database oracle or not | `bool` | `true` | no |
| <a name="input_create_monitoring_role"></a> [create_monitoring_role](#input_create_monitoring_role) | Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input_env) | n/a | `string` | `""` | no |
| <a name="input_exclude_role_creation_based_on_iam_policies"></a> [exclude_role_creation_based_on_iam_policies](#input_exclude_role_creation_based_on_iam_policies) | n/a | `list(string)` | `[]` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam_database_authentication_enabled](#input_iam_database_authentication_enabled) | n/a | `bool` | `true` | no |
| <a name="input_iam_policies"></a> [iam_policies](#input_iam_policies) | n/a | `list(string)` | `[]` | no |
| <a name="input_iam_roles"></a> [iam_roles](#input_iam_roles) | ############################################################################### # AWS IAM Roles ############################################################################### | `list(string)` | `[]` | no |
| <a name="input_identity_providers"></a> [identity_providers](#input_identity_providers) | n/a | `any` | `{}` | no |
| <a name="input_ignore_value_changes"></a> [ignore_value_changes](#input_ignore_value_changes) | Whether to ignore future external changes in paramater values | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms_key_id](#input_kms_key_id) | The ARN for the KMS encryption key | `string` | `null` | no |
| <a name="input_monitoring_interval"></a> [monitoring_interval](#input_monitoring_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60 | `number` | `15` | no |
| <a name="input_monitoring_role_name"></a> [monitoring_role_name](#input_monitoring_role_name) | Name of the IAM role which will be created when create_monitoring_role is enabled | `string` | `"kong-rds-monitoring-role"` | no |
| <a name="input_parameter_read"></a> [parameter_read](#input_parameter_read) | List of parameters to read from SSM. These must already exist otherwise an error is returned. Can be used with `parameter_write` as long as the parameters are different. | `list(string)` | `[]` | no |
| <a name="input_parameter_write"></a> [parameter_write](#input_parameter_write) | List of maps with the parameter values to write to SSM Parameter Store | `list(map(string))` | `[]` | no |
| <a name="input_parameter_write_defaults"></a> [parameter_write_defaults](#input_parameter_write_defaults) | Parameter write default settings | `map(any)` | <pre>{<br/>  "allowed_pattern": null,<br/>  "data_type": "text",<br/>  "description": null,<br/>  "overwrite": "false",<br/>  "tier": "Standard",<br/>  "type": "SecureString",<br/>  "value": "temp"<br/>}</pre> | no |
| <a name="input_performance_insights_enabled"></a> [performance_insights_enabled](#input_performance_insights_enabled) | Specifies whether Performance Insights are enabled | `bool` | `false` | no |
| <a name="input_postgres_additional_parameters"></a> [postgres_additional_parameters](#input_postgres_additional_parameters) | n/a | `list(any)` | `[]` | no |
| <a name="input_postgresql_additional_tags"></a> [postgresql_additional_tags](#input_postgresql_additional_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_postgresql_allocated_storage"></a> [postgresql_allocated_storage](#input_postgresql_allocated_storage) | The allocated storage in gigabytes | `string` | `null` | no |
| <a name="input_postgresql_allow_major_version_upgrade"></a> [postgresql_allow_major_version_upgrade](#input_postgresql_allow_major_version_upgrade) | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `bool` | `false` | no |
| <a name="input_postgresql_auto_minor_version_upgrade"></a> [postgresql_auto_minor_version_upgrade](#input_postgresql_auto_minor_version_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| <a name="input_postgresql_backup_retention_period"></a> [postgresql_backup_retention_period](#input_postgresql_backup_retention_period) | The days to retain backups for | `number` | `null` | no |
| <a name="input_postgresql_backup_window"></a> [postgresql_backup_window](#input_postgresql_backup_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window | `string` | `null` | no |
| <a name="input_postgresql_dbname"></a> [postgresql_dbname](#input_postgresql_dbname) | The db name of rds | `string` | `null` | no |
| <a name="input_postgresql_deletion_protection"></a> [postgresql_deletion_protection](#input_postgresql_deletion_protection) | The database can't be deleted when this value is set to true | `bool` | `false` | no |
| <a name="input_postgresql_enabled_cloudwatch_logs_exports"></a> [postgresql_enabled_cloudwatch_logs_exports](#input_postgresql_enabled_cloudwatch_logs_exports) | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list(string)` | `[]` | no |
| <a name="input_postgresql_instance_class"></a> [postgresql_instance_class](#input_postgresql_instance_class) | The instance type of the RDS instance | `string` | `null` | no |
| <a name="input_postgresql_maintenance_window"></a> [postgresql_maintenance_window](#input_postgresql_maintenance_window) | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `string` | `null` | no |
| <a name="input_postgresql_max_allocated_storage"></a> [postgresql_max_allocated_storage](#input_postgresql_max_allocated_storage) | Specifies the value for Storage Autoscaling | `number` | `0` | no |
| <a name="input_postgresql_multi_az"></a> [postgresql_multi_az](#input_postgresql_multi_az) | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| <a name="input_postgresql_storage_type"></a> [postgresql_storage_type](#input_postgresql_storage_type) | One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter | `string` | `null` | no |
| <a name="input_postgresql_username"></a> [postgresql_username](#input_postgresql_username) | The username of rds | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input_prefix) | (optional) prefix name for resources | `string` | `"bdo"` | no |
| <a name="input_rds_schedule_tags"></a> [rds_schedule_tags](#input_rds_schedule_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_region"></a> [region](#input_region) | Active region | `string` | `"us-east-2"` | no |
| <a name="input_session_name"></a> [session_name](#input_session_name) | (Optional) Session name to use when assuming the role. | `string` | `"BDO_AWS_INFRASTRUCTURE"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | n/a | `map(string)` | `{}` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account_id](#output_account_id) | n/a |
| <a name="output_caller_arn"></a> [caller_arn](#output_caller_arn) | n/a |
| <a name="output_caller_user"></a> [caller_user](#output_caller_user) | n/a |
| <a name="output_region"></a> [region](#output_region) | n/a |

<br/>

<!-- END_TF_DOCS -->