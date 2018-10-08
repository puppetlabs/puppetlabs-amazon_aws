Document: "rds"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/rds/2014-10-31/api-2.json")

## DBSecurityGroup



```puppet
aws_db_security_group {
  db_security_group_description => "db_security_group_description (optional)",
  db_security_group_name => "db_security_group_name (optional)",
  filters => "Filters (optional)",
  max_records => "MaxRecords (optional)",
  tags => "Tags (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|db_security_group_description | String | false |
|db_security_group_name | String | false |
|filters | FilterList | false |
|max_records | IntegerOptional | false |
|tags | TagList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the DBSecurityGroup

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a new DB security group. DB security groups control access to a DB instance.</p> <note> <p>A DB security group controls access to EC2-Classic DB instances that are not in a VPC.</p> </note>|CreateDBSecurityGroup|
|List - list all|`/`|POST|<p> Returns a list of <code>DBSecurityGroup</code> descriptions. If a <code>DBSecurityGroupName</code> is specified, the list will contain only the descriptions of the specified DB security group. </p>|DescribeDBSecurityGroups|
|List - get one|``||||
|List - get list using params|`/`|POST|<p> Returns a list of <code>DBSecurityGroup</code> descriptions. If a <code>DBSecurityGroupName</code> is specified, the list will contain only the descriptions of the specified DB security group. </p>|DescribeDBSecurityGroups|
|Update|``||||
|Delete|`/`|POST|<p>Deletes a DB security group.</p> <note> <p>The specified DB security group must not be associated with any DB instances.</p> </note>|DeleteDBSecurityGroup|
