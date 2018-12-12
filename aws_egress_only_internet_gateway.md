Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## EgressOnlyInternetGateway



```puppet
aws_egress_only_internet_gateway {
  client_token => "client_token (optional)",
  dry_run => "DryRun (optional)",
  egress_only_internet_gateway_id => $aws_egress_only_internet_gateway_id
  egress_only_internet_gateway_ids => "EgressOnlyInternetGatewayIds (optional)",
  vpc_id => "vpc_id (optional)",
  max_results => "1234 (optional)",
  next_token => "next_token (optional)",
  vpc_id => "vpc_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|client_token | String | false |
|dry_run | Boolean | false |
|egress_only_internet_gateway_id | [EgressOnlyInternetGatewayId](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=egressonlyinternetgatewayid) | false |
|egress_only_internet_gateway_ids | EgressOnlyInternetGatewayIdList | false |
|vpc_id | String | false |
|max_results | Integer | false |
|next_token | String | false |
|vpc_id | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the EgressOnlyInternetGateway

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>[IPv6 only] Creates an egress-only internet gateway for your VPC. An egress-only internet gateway is used to enable outbound communication over IPv6 from instances in your VPC to the internet, and prevents hosts outside of your VPC from initiating an IPv6 connection with your instance.</p>|CreateEgressOnlyInternetGateway|
|List - list all|`/`|POST|<p>Describes one or more of your egress-only internet gateways.</p>|DescribeEgressOnlyInternetGateways|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your egress-only internet gateways.</p>|DescribeEgressOnlyInternetGateways|
|Update|``||||
|Delete|`/`|POST|<p>Deletes an egress-only internet gateway.</p>|DeleteEgressOnlyInternetGateway|
