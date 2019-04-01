Document: "rds"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/rds/2014-10-31/api-2.json")

## DBCluster



```puppet
aws_db_cluster {
  apply_immediately => "ApplyImmediately (optional)",
  availability_zones => "AvailabilityZones (optional)",
  backtrack_window => $aws_long_optional
  backup_retention_period => "BackupRetentionPeriod (optional)",
  character_set_name => "character_set_name (optional)",
  cloudwatch_logs_export_configuration => $aws_cloudwatch_logs_export_configuration
  copy_tags_to_snapshot => "CopyTagsToSnapshot (optional)",
  database_name => "database_name (optional)",
  db_cluster_identifier => "db_cluster_identifier (optional)",
  db_cluster_parameter_group_name => "db_cluster_parameter_group_name (optional)",
  db_subnet_group_name => "db_subnet_group_name (optional)",
  deletion_protection => "DeletionProtection (optional)",
  enable_cloudwatch_logs_exports => "EnableCloudwatchLogsExports (optional)",
  enable_http_endpoint => "EnableHttpEndpoint (optional)",
  enable_iam_database_authentication => "EnableIAMDatabaseAuthentication (optional)",
  engine => "engine (optional)",
  engine_mode => "engine_mode (optional)",
  engine_version => "engine_version (optional)",
  filters => "Filters (optional)",
  final_db_snapshot_identifier => "final_db_snapshot_identifier (optional)",
  global_cluster_identifier => "global_cluster_identifier (optional)",
  kms_key_id => "kms_key_id (optional)",
  master_username => "master_username (optional)",
  master_user_password => "master_user_password (optional)",
  max_records => "MaxRecords (optional)",
  option_group_name => "option_group_name (optional)",
  new_db_cluster_identifier => "new_db_cluster_identifier (optional)",
  option_group_name => "option_group_name (optional)",
  port => "Port (optional)",
  preferred_backup_window => "preferred_backup_window (optional)",
  preferred_maintenance_window => "preferred_maintenance_window (optional)",
  pre_signed_url => "pre_signed_url (optional)",
  replication_source_identifier => "replication_source_identifier (optional)",
  scaling_configuration => $aws_scaling_configuration
  skip_final_snapshot => "SkipFinalSnapshot (optional)",
  storage_encrypted => "StorageEncrypted (optional)",
  tags => "Tags (optional)",
  vpc_security_group_ids => "VpcSecurityGroupIds (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|apply_immediately | Boolean | false |
|availability_zones | AvailabilityZones | false |
|backtrack_window | [LongOptional](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|backup_retention_period | IntegerOptional | false |
|character_set_name | String | false |
|cloudwatch_logs_export_configuration | [CloudwatchLogsExportConfiguration](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|copy_tags_to_snapshot | BooleanOptional | false |
|database_name | String | false |
|db_cluster_identifier | String | false |
|db_cluster_parameter_group_name | String | false |
|db_subnet_group_name | String | false |
|deletion_protection | BooleanOptional | false |
|enable_cloudwatch_logs_exports | LogTypeList | false |
|enable_http_endpoint | BooleanOptional | false |
|enable_iam_database_authentication | BooleanOptional | false |
|engine | String | false |
|engine_mode | String | false |
|engine_version | String | false |
|filters | FilterList | false |
|final_db_snapshot_identifier | String | false |
|global_cluster_identifier | String | false |
|kms_key_id | String | false |
|master_username | String | false |
|master_user_password | String | false |
|max_records | IntegerOptional | false |
|option_group_name | String | false |
|new_db_cluster_identifier | String | false |
|option_group_name | String | false |
|port | IntegerOptional | false |
|preferred_backup_window | String | false |
|preferred_maintenance_window | String | false |
|pre_signed_url | String | false |
|replication_source_identifier | String | false |
|scaling_configuration | [ScalingConfiguration](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|skip_final_snapshot | Boolean | false |
|storage_encrypted | BooleanOptional | false |
|tags | TagList | false |
|vpc_security_group_ids | VpcSecurityGroupIdList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the DBCluster

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a new Amazon Aurora DB cluster.</p> <p>You can use the <code>ReplicationSourceIdentifier</code> parameter to create the DB cluster as a Read Replica of another DB cluster or Amazon RDS MySQL DB instance. For cross-region replication where the DB cluster identified by <code>ReplicationSourceIdentifier</code> is encrypted, you must also specify the <code>PreSignedUrl</code> parameter.</p> <p>For more information on Amazon Aurora, see <a href="https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>|CreateDBCluster|
|List - list all|`/`|POST|<p>Returns information about provisioned Aurora DB clusters. This API supports pagination.</p> <p>For more information on Amazon Aurora, see <a href="https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>|DescribeDBClusters|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Returns information about provisioned Aurora DB clusters. This API supports pagination.</p> <p>For more information on Amazon Aurora, see <a href="https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>|DescribeDBClusters|
|Update|`/`|POST|<p>Modify a setting for an Amazon Aurora DB cluster. You can change one or more database configuration parameters by specifying these parameters and the new values in the request. For more information on Amazon Aurora, see <a href="https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>|ModifyDBCluster|
|Delete|`/`|POST|<p>The DeleteDBCluster action deletes a previously provisioned DB cluster. When you delete a DB cluster, all automated backups for that DB cluster are deleted and can't be recovered. Manual DB cluster snapshots of the specified DB cluster are not deleted.</p> <p/> <p>For more information on Amazon Aurora, see <a href="https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>|DeleteDBCluster|
