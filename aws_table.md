Document: "dynamodb"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/dynamodb/2012-08-10/api-2.json")

## Table



```puppet
aws_table {
  attribute_definitions => "AttributeDefinitions (optional)",
  billing_mode => $aws_billing_mode
  global_secondary_indexes => "GlobalSecondaryIndexes (optional)",
  key_schema => "KeySchema (optional)",
  local_secondary_indexes => "LocalSecondaryIndexes (optional)",
  provisioned_throughput => $aws_provisioned_throughput
  sse_specification => $aws_sse_specification
  stream_specification => $aws_stream_specification
  table_name => $aws_table_name
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|attribute_definitions | AttributeDefinitions | false |
|billing_mode | [BillingMode](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|global_secondary_indexes | GlobalSecondaryIndexList | false |
|key_schema | KeySchema | false |
|local_secondary_indexes | LocalSecondaryIndexList | false |
|provisioned_throughput | [ProvisionedThroughput](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|sse_specification | [SSESpecification](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|stream_specification | [StreamSpecification](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|table_name | [TableName](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the Table

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>The <code>CreateTable</code> operation adds a new table to your account. In an AWS account, table names must be unique within each region. That is, you can have two tables with same name if you create the tables in different regions.</p> <p> <code>CreateTable</code> is an asynchronous operation. Upon receiving a <code>CreateTable</code> request, DynamoDB immediately returns a response with a <code>TableStatus</code> of <code>CREATING</code>. After the table is created, DynamoDB sets the <code>TableStatus</code> to <code>ACTIVE</code>. You can perform read and write operations only on an <code>ACTIVE</code> table. </p> <p>You can optionally define secondary indexes on the new table, as part of the <code>CreateTable</code> operation. If you want to create multiple tables with secondary indexes on them, you must create the tables sequentially. Only one table with secondary indexes can be in the <code>CREATING</code> state at any given time.</p> <p>You can use the <code>DescribeTable</code> action to check the table status.</p>|CreateTable|
|List - list all|``||||
|List - get one|`/`|POST|<p>Returns information about the table, including the current status of the table, when it was created, the primary key schema, and any indexes on the table.</p> <note> <p>If you issue a <code>DescribeTable</code> request immediately after a <code>CreateTable</code> request, DynamoDB might return a <code>ResourceNotFoundException</code>. This is because <code>DescribeTable</code> uses an eventually consistent query, and the metadata for your table might not be available at that moment. Wait for a few seconds, and then try the <code>DescribeTable</code> request again.</p> </note>|DescribeTable|
|List - get list using params|``||||
|Update|``||||
|Delete|`/`|POST|<p>The <code>DeleteTable</code> operation deletes a table and all of its items. After a <code>DeleteTable</code> request, the specified table is in the <code>DELETING</code> state until DynamoDB completes the deletion. If the table is in the <code>ACTIVE</code> state, you can delete it. If a table is in <code>CREATING</code> or <code>UPDATING</code> states, then DynamoDB returns a <code>ResourceInUseException</code>. If the specified table does not exist, DynamoDB returns a <code>ResourceNotFoundException</code>. If table is already in the <code>DELETING</code> state, no error is returned. </p> <note> <p>DynamoDB might continue to accept data read and write operations, such as <code>GetItem</code> and <code>PutItem</code>, on a table in the <code>DELETING</code> state until the table deletion is complete.</p> </note> <p>When you delete a table, any indexes on that table are also deleted.</p> <p>If you have DynamoDB Streams enabled on the table, then the corresponding stream on that table goes into the <code>DISABLED</code> state, and the stream is automatically deleted after 24 hours.</p> <p>Use the <code>DescribeTable</code> action to check the status of the table. </p>|DeleteTable|
