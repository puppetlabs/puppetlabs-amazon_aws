Document: "rds"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/rds/2014-10-31/api-2.json")

## DBSubnetGroup



```puppet
aws_db_subnet_group {
  db_subnet_group_description => "db_subnet_group_description (optional)",
  db_subnet_group_name => "db_subnet_group_name (optional)",
  filters => "Filters (optional)",
  max_records => "MaxRecords (optional)",
  subnet_ids => "SubnetIds (optional)",
  tags => "Tags (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|db_subnet_group_description | String | false |
|db_subnet_group_name | String | false |
|filters | FilterList | false |
|max_records | IntegerOptional | false |
|subnet_ids | SubnetIdentifierList | false |
|tags | TagList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the DBSubnetGroup

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a new DB subnet group. DB subnet groups must contain at least one subnet in at least two AZs in the AWS Region.</p>|CreateDBSubnetGroup|
|List - list all|`/`|POST|<p>Returns a list of DBSubnetGroup descriptions. If a DBSubnetGroupName is specified, the list will contain only the descriptions of the specified DBSubnetGroup.</p> <p>For an overview of CIDR ranges, go to the <a href="http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing">Wikipedia Tutorial</a>. </p>|DescribeDBSubnetGroups|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Returns a list of DBSubnetGroup descriptions. If a DBSubnetGroupName is specified, the list will contain only the descriptions of the specified DBSubnetGroup.</p> <p>For an overview of CIDR ranges, go to the <a href="http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing">Wikipedia Tutorial</a>. </p>|DescribeDBSubnetGroups|
|Update|`/`|POST|<p>Modifies an existing DB subnet group. DB subnet groups must contain at least one subnet in at least two AZs in the AWS Region.</p>|ModifyDBSubnetGroup|
|Delete|`/`|POST|<p>Deletes a DB subnet group.</p> <note> <p>The specified database subnet group must not be associated with any DB instances.</p> </note>|DeleteDBSubnetGroup|
