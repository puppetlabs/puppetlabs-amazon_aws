Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## PlacementGroup



```puppet
aws_placement_group {
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  group_name => "group_name (optional)",
  group_names => "GroupNames (optional)",
  group_name => "group_name (optional)",
  partition_count => "1234 (optional)",
  strategy => $aws_placement_strategy
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|dry_run | Boolean | false |
|filters | FilterList | false |
|group_name | String | false |
|group_names | PlacementGroupStringList | false |
|group_name | String | false |
|partition_count | Integer | false |
|strategy | [PlacementStrategy](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the PlacementGroup

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a placement group in which to launch instances. The strategy of the placement group determines how the instances are organized within the group. </p> <p>A <code>cluster</code> placement group is a logical grouping of instances within a single Availability Zone that benefit from low network latency, high network throughput. A <code>spread</code> placement group places instances on distinct hardware. A <code>partition</code> placement group places groups of instances in different partitions, where instances in one partition do not share the same hardware with instances in another partition.</p> <p>For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html">Placement Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|CreatePlacementGroup|
|List - list all|`/`|POST|<p>Describes one or more of your placement groups. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html">Placement Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DescribePlacementGroups|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your placement groups. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html">Placement Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DescribePlacementGroups|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified placement group. You must terminate all instances in the placement group before you can delete the placement group. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html">Placement Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DeletePlacementGroup|
