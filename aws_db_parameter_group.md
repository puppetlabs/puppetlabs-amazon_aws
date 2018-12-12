Document: "rds"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/rds/2014-10-31/api-2.json")

## DBParameterGroup



```puppet
aws_db_parameter_group {
  db_parameter_group_family => "db_parameter_group_family (optional)",
  db_parameter_group_name => "db_parameter_group_name (optional)",
  description => "description (optional)",
  filters => "Filters (optional)",
  max_records => "MaxRecords (optional)",
  parameters => "Parameters (optional)",
  tags => "Tags (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|db_parameter_group_family | String | false |
|db_parameter_group_name | String | false |
|description | String | false |
|filters | FilterList | false |
|max_records | IntegerOptional | false |
|parameters | ParametersList | false |
|tags | TagList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the DBParameterGroup

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a new DB parameter group.</p> <p> A DB parameter group is initially created with the default parameters for the database engine used by the DB instance. To provide custom values for any of the parameters, you must modify the group after creating it using <i>ModifyDBParameterGroup</i>. Once you've created a DB parameter group, you need to associate it with your DB instance using <i>ModifyDBInstance</i>. When you associate a new DB parameter group with a running DB instance, you need to reboot the DB instance without failover for the new DB parameter group and associated settings to take effect. </p> <important> <p>After you create a DB parameter group, you should wait at least 5 minutes before creating your first DB instance that uses that DB parameter group as the default parameter group. This allows Amazon RDS to fully complete the create action before the parameter group is used as the default for a new DB instance. This is especially important for parameters that are critical when creating the default database for a DB instance, such as the character set for the default database defined by the <code>character_set_database</code> parameter. You can use the <i>Parameter Groups</i> option of the <a href="https://console.aws.amazon.com/rds/">Amazon RDS console</a> or the <i>DescribeDBParameters</i> command to verify that your DB parameter group has been created or modified.</p> </important>|CreateDBParameterGroup|
|List - list all|`/`|POST|<p> Returns a list of <code>DBParameterGroup</code> descriptions. If a <code>DBParameterGroupName</code> is specified, the list will contain only the description of the specified DB parameter group. </p>|DescribeDBParameterGroups|
|List - get one|``||||
|List - get list using params|`/`|POST|<p> Returns a list of <code>DBParameterGroup</code> descriptions. If a <code>DBParameterGroupName</code> is specified, the list will contain only the description of the specified DB parameter group. </p>|DescribeDBParameterGroups|
|Update|`/`|POST|<p> Modifies the parameters of a DB parameter group. To modify more than one parameter, submit a list of the following: <code>ParameterName</code>, <code>ParameterValue</code>, and <code>ApplyMethod</code>. A maximum of 20 parameters can be modified in a single request. </p> <note> <p>Changes to dynamic parameters are applied immediately. Changes to static parameters require a reboot without failover to the DB instance associated with the parameter group before the change can take effect.</p> </note> <important> <p>After you modify a DB parameter group, you should wait at least 5 minutes before creating your first DB instance that uses that DB parameter group as the default parameter group. This allows Amazon RDS to fully complete the modify action before the parameter group is used as the default for a new DB instance. This is especially important for parameters that are critical when creating the default database for a DB instance, such as the character set for the default database defined by the <code>character_set_database</code> parameter. You can use the <i>Parameter Groups</i> option of the <a href="https://console.aws.amazon.com/rds/">Amazon RDS console</a> or the <i>DescribeDBParameters</i> command to verify that your DB parameter group has been created or modified.</p> </important>|ModifyDBParameterGroup|
|Delete|`/`|POST|<p>Deletes a specified DB parameter group. The DB parameter group to be deleted can't be associated with any DB instances.</p>|DeleteDBParameterGroup|
