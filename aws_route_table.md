Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## RouteTable



```puppet
aws_route_table {
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  vpc_id => "vpc_id (optional)",
  max_results => "1234 (optional)",
  next_token => "next_token (optional)",
  route_table_id => "route_table_id (optional)",
  route_table_ids => "RouteTableIds (optional)",
  vpc_id => "vpc_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|dry_run | Boolean | false |
|filters | FilterList | false |
|vpc_id | String | false |
|max_results | Integer | false |
|next_token | String | false |
|route_table_id | String | false |
|route_table_ids | ValueStringList | false |
|vpc_id | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the RouteTable

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a route table for the specified VPC. After you create a route table, you can add routes and associate the table with a subnet.</p> <p>For more information, see <a href="https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Route_Tables.html">Route Tables</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|CreateRouteTable|
|List - list all|`/`|POST|<p>Describes one or more of your route tables.</p> <p>Each subnet in your VPC must be associated with a route table. If a subnet is not explicitly associated with any route table, it is implicitly associated with the main route table. This command does not return the subnet ID for implicit associations.</p> <p>For more information, see <a href="https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Route_Tables.html">Route Tables</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeRouteTables|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your route tables.</p> <p>Each subnet in your VPC must be associated with a route table. If a subnet is not explicitly associated with any route table, it is implicitly associated with the main route table. This command does not return the subnet ID for implicit associations.</p> <p>For more information, see <a href="https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Route_Tables.html">Route Tables</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeRouteTables|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified route table. You must disassociate the route table from any subnets before you can delete it. You can't delete the main route table.</p>|DeleteRouteTable|
