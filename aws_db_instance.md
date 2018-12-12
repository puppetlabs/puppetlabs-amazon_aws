Document: "rds"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/rds/2014-10-31/api-2.json")

## DBInstance



```puppet
aws_db_instance {
  allocated_storage => "AllocatedStorage (optional)",
  allow_major_version_upgrade => "AllowMajorVersionUpgrade (optional)",
  apply_immediately => "ApplyImmediately (optional)",
  auto_minor_version_upgrade => "AutoMinorVersionUpgrade (optional)",
  availability_zone => "availability_zone (optional)",
  backup_retention_period => "BackupRetentionPeriod (optional)",
  ca_certificate_identifier => "ca_certificate_identifier (optional)",
  character_set_name => "character_set_name (optional)",
  cloudwatch_logs_export_configuration => $aws_cloudwatch_logs_export_configuration
  copy_tags_to_snapshot => "CopyTagsToSnapshot (optional)",
  db_cluster_identifier => "db_cluster_identifier (optional)",
  db_instance_class => "db_instance_class (optional)",
  db_instance_identifier => "db_instance_identifier (optional)",
  db_name => "db_name (optional)",
  db_parameter_group_name => "db_parameter_group_name (optional)",
  db_port_number => "DBPortNumber (optional)",
  db_security_groups => "DBSecurityGroups (optional)",
  db_subnet_group_name => "db_subnet_group_name (optional)",
  delete_automated_backups => "DeleteAutomatedBackups (optional)",
  deletion_protection => "DeletionProtection (optional)",
  domain => "domain (optional)",
  domain_iam_role_name => "domain_iam_role_name (optional)",
  enable_cloudwatch_logs_exports => "EnableCloudwatchLogsExports (optional)",
  enable_iam_database_authentication => "EnableIAMDatabaseAuthentication (optional)",
  enable_performance_insights => "EnablePerformanceInsights (optional)",
  engine => "engine (optional)",
  engine_version => "engine_version (optional)",
  filters => "Filters (optional)",
  final_db_snapshot_identifier => "final_db_snapshot_identifier (optional)",
  iops => "Iops (optional)",
  kms_key_id => "kms_key_id (optional)",
  license_model => "license_model (optional)",
  master_username => "master_username (optional)",
  master_user_password => "master_user_password (optional)",
  max_records => "MaxRecords (optional)",
  monitoring_interval => "MonitoringInterval (optional)",
  monitoring_role_arn => "monitoring_role_arn (optional)",
  multi_az => "MultiAZ (optional)",
  db_parameter_group_name => "db_parameter_group_name (optional)",
  new_db_instance_identifier => "new_db_instance_identifier (optional)",
  option_group_name => "option_group_name (optional)",
  performance_insights_kms_key_id => "performance_insights_kms_key_id (optional)",
  performance_insights_retention_period => "PerformanceInsightsRetentionPeriod (optional)",
  port => "Port (optional)",
  preferred_backup_window => "preferred_backup_window (optional)",
  preferred_maintenance_window => "preferred_maintenance_window (optional)",
  processor_features => "ProcessorFeatures (optional)",
  promotion_tier => "PromotionTier (optional)",
  publicly_accessible => "PubliclyAccessible (optional)",
  skip_final_snapshot => "SkipFinalSnapshot (optional)",
  storage_encrypted => "StorageEncrypted (optional)",
  storage_type => "storage_type (optional)",
  tags => "Tags (optional)",
  tde_credential_arn => "tde_credential_arn (optional)",
  tde_credential_password => "tde_credential_password (optional)",
  timezone => "timezone (optional)",
  use_default_processor_features => "UseDefaultProcessorFeatures (optional)",
  vpc_security_group_ids => "VpcSecurityGroupIds (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|allocated_storage | IntegerOptional | false |
|allow_major_version_upgrade | Boolean | false |
|apply_immediately | Boolean | false |
|auto_minor_version_upgrade | BooleanOptional | false |
|availability_zone | String | false |
|backup_retention_period | IntegerOptional | false |
|ca_certificate_identifier | String | false |
|character_set_name | String | false |
|cloudwatch_logs_export_configuration | [CloudwatchLogsExportConfiguration](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=cloudwatchlogsexportconfiguration) | false |
|copy_tags_to_snapshot | BooleanOptional | false |
|db_cluster_identifier | String | false |
|db_instance_class | String | false |
|db_instance_identifier | String | false |
|db_name | String | false |
|db_parameter_group_name | String | false |
|db_port_number | IntegerOptional | false |
|db_security_groups | DBSecurityGroupNameList | false |
|db_subnet_group_name | String | false |
|delete_automated_backups | BooleanOptional | false |
|deletion_protection | BooleanOptional | false |
|domain | String | false |
|domain_iam_role_name | String | false |
|enable_cloudwatch_logs_exports | LogTypeList | false |
|enable_iam_database_authentication | BooleanOptional | false |
|enable_performance_insights | BooleanOptional | false |
|engine | String | false |
|engine_version | String | false |
|filters | FilterList | false |
|final_db_snapshot_identifier | String | false |
|iops | IntegerOptional | false |
|kms_key_id | String | false |
|license_model | String | false |
|master_username | String | false |
|master_user_password | String | false |
|max_records | IntegerOptional | false |
|monitoring_interval | IntegerOptional | false |
|monitoring_role_arn | String | false |
|multi_az | BooleanOptional | false |
|db_parameter_group_name | String | false |
|new_db_instance_identifier | String | false |
|option_group_name | String | false |
|performance_insights_kms_key_id | String | false |
|performance_insights_retention_period | IntegerOptional | false |
|port | IntegerOptional | false |
|preferred_backup_window | String | false |
|preferred_maintenance_window | String | false |
|processor_features | ProcessorFeatureList | false |
|promotion_tier | IntegerOptional | false |
|publicly_accessible | BooleanOptional | false |
|skip_final_snapshot | Boolean | false |
|storage_encrypted | BooleanOptional | false |
|storage_type | String | false |
|tags | TagList | false |
|tde_credential_arn | String | false |
|tde_credential_password | String | false |
|timezone | String | false |
|use_default_processor_features | BooleanOptional | false |
|vpc_security_group_ids | VpcSecurityGroupIdList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the DBInstance

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a new DB instance.</p>|CreateDBInstance|
|List - list all|`/`|POST|<p>Returns information about provisioned RDS instances. This API supports pagination.</p>|DescribeDBInstances|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Returns information about provisioned RDS instances. This API supports pagination.</p>|DescribeDBInstances|
|Update|`/`|POST|<p>Modifies settings for a DB instance. You can change one or more database configuration parameters by specifying these parameters and the new values in the request. To learn what modifications you can make to your DB instance, call <a>DescribeValidDBInstanceModifications</a> before you call <a>ModifyDBInstance</a>. </p>|ModifyDBInstance|
|Delete|`/`|POST|<p>The DeleteDBInstance action deletes a previously provisioned DB instance. When you delete a DB instance, all automated backups for that instance are deleted and can't be recovered. Manual DB snapshots of the DB instance to be deleted by <code>DeleteDBInstance</code> are not deleted.</p> <p> If you request a final DB snapshot the status of the Amazon RDS DB instance is <code>deleting</code> until the DB snapshot is created. The API action <code>DescribeDBInstance</code> is used to monitor the status of this operation. The action can't be canceled or reverted once submitted. </p> <p>Note that when a DB instance is in a failure state and has a status of <code>failed</code>, <code>incompatible-restore</code>, or <code>incompatible-network</code>, you can only delete it when the <code>SkipFinalSnapshot</code> parameter is set to <code>true</code>.</p> <p>If the specified DB instance is part of an Amazon Aurora DB cluster, you can't delete the DB instance if both of the following conditions are true:</p> <ul> <li> <p>The DB cluster is a Read Replica of another Amazon Aurora DB cluster.</p> </li> <li> <p>The DB instance is the only instance in the DB cluster.</p> </li> </ul> <p>To delete a DB instance in this case, first call the <a>PromoteReadReplicaDBCluster</a> API action to promote the DB cluster so it's no longer a Read Replica. After the promotion completes, then call the <code>DeleteDBInstance</code> API action to delete the final instance in the DB cluster.</p>|DeleteDBInstance|
