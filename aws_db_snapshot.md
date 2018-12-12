Document: "rds"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/rds/2014-10-31/api-2.json")

## DBSnapshot



```puppet
aws_db_snapshot {
  db_instance_identifier => "db_instance_identifier (optional)",
  dbi_resource_id => "dbi_resource_id (optional)",
  db_snapshot_identifier => "db_snapshot_identifier (optional)",
  engine_version => "engine_version (optional)",
  filters => "Filters (optional)",
  dbi_resource_id => "dbi_resource_id (optional)",
  include_public => "IncludePublic (optional)",
  include_shared => "IncludeShared (optional)",
  max_records => "MaxRecords (optional)",
  option_group_name => "option_group_name (optional)",
  snapshot_type => "snapshot_type (optional)",
  tags => "Tags (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|db_instance_identifier | String | false |
|dbi_resource_id | String | false |
|db_snapshot_identifier | String | false |
|engine_version | String | false |
|filters | FilterList | false |
|dbi_resource_id | String | false |
|include_public | Boolean | false |
|include_shared | Boolean | false |
|max_records | IntegerOptional | false |
|option_group_name | String | false |
|snapshot_type | String | false |
|tags | TagList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the DBSnapshot

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a DBSnapshot. The source DBInstance must be in "available" state.</p>|CreateDBSnapshot|
|List - list all|`/`|POST|<p>Returns information about DB snapshots. This API action supports pagination.</p>|DescribeDBSnapshots|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Returns information about DB snapshots. This API action supports pagination.</p>|DescribeDBSnapshots|
|Update|`/`|POST|<p>Updates a manual DB snapshot, which can be encrypted or not encrypted, with a new engine version. </p> <p>Amazon RDS supports upgrading DB snapshots for MySQL and Oracle. </p>|ModifyDBSnapshot|
|Delete|`/`|POST|<p>Deletes a DB snapshot. If the snapshot is being copied, the copy operation is terminated.</p> <note> <p>The DB snapshot must be in the <code>available</code> state to be deleted.</p> </note>|DeleteDBSnapshot|
