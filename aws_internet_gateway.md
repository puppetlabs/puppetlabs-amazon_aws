Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## InternetGateway



```puppet
aws_internet_gateway {
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  internet_gateway_id => "internet_gateway_id (optional)",
  internet_gateway_ids => "InternetGatewayIds (optional)",
  max_results => "MaxResults (optional)",
  next_token => "next_token (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|dry_run | Boolean | false |
|filters | FilterList | false |
|internet_gateway_id | String | false |
|internet_gateway_ids | ValueStringList | false |
|max_results | DescribeInternetGatewaysMaxResults | false |
|next_token | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the InternetGateway

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates an internet gateway for use with a VPC. After creating the internet gateway, you attach it to a VPC using <a>AttachInternetGateway</a>.</p> <p>For more information about your VPC and internet gateway, see the <a href="https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/">Amazon Virtual Private Cloud User Guide</a>.</p>|CreateInternetGateway|
|List - list all|`/`|POST|<p>Describes one or more of your internet gateways.</p>|DescribeInternetGateways|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your internet gateways.</p>|DescribeInternetGateways|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified internet gateway. You must detach the internet gateway from the VPC before you can delete it.</p>|DeleteInternetGateway|
