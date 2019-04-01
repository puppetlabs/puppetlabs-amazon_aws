Document: "rds"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/rds/2014-10-31/api-2.json")

## DBClusterSnapshot



```puppet
aws_db_cluster_snapshot {
  db_cluster_identifier => "db_cluster_identifier (optional)",
  db_cluster_snapshot_identifier => "db_cluster_snapshot_identifier (optional)",
  filters => "Filters (optional)",
  include_public => "IncludePublic (optional)",
  include_shared => "IncludeShared (optional)",
  max_records => "MaxRecords (optional)",
  snapshot_type => "snapshot_type (optional)",
  tags => "Tags (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|db_cluster_identifier | String | false |
|db_cluster_snapshot_identifier | String | false |
|filters | FilterList | false |
|include_public | Boolean | false |
|include_shared | Boolean | false |
|max_records | IntegerOptional | false |
|snapshot_type | String | false |
|tags | TagList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the DBClusterSnapshot

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a snapshot of a DB cluster. For more information on Amazon Aurora, see <a href="https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>|CreateDBClusterSnapshot|
|List - list all|`/`|POST|<p>Returns information about DB cluster snapshots. This API action supports pagination.</p> <p>For more information on Amazon Aurora, see <a href="https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>|DescribeDBClusterSnapshots|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Returns information about DB cluster snapshots. This API action supports pagination.</p> <p>For more information on Amazon Aurora, see <a href="https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>|DescribeDBClusterSnapshots|
|Update|``||||
|Delete|`/`|POST|<p>Deletes a DB cluster snapshot. If the snapshot is being copied, the copy operation is terminated.</p> <note> <p>The DB cluster snapshot must be in the <code>available</code> state to be deleted.</p> </note> <p>For more information on Amazon Aurora, see <a href="https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>|DeleteDBClusterSnapshot|
