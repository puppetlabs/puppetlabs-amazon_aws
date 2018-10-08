Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## VpnGateway



```puppet
aws_vpn_gateway {
  amazon_side_asn => $aws_long
  availability_zone => "availability_zone (optional)",
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  type => $aws_gateway_type
  vpn_gateway_id => "vpn_gateway_id (optional)",
  vpn_gateway_ids => "VpnGatewayIds (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|amazon_side_asn | [Long](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=long) | false |
|availability_zone | String | false |
|dry_run | Boolean | false |
|filters | FilterList | false |
|type | [GatewayType](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=gatewaytype) | false |
|vpn_gateway_id | String | false |
|vpn_gateway_ids | VpnGatewayIdStringList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the VpnGateway

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a virtual private gateway. A virtual private gateway is the endpoint on the VPC side of your VPN connection. You can create a virtual private gateway before creating the VPC itself.</p> <p>For more information about virtual private gateways, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html">AWS Managed VPN Connections</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|CreateVpnGateway|
|List - list all|`/`|POST|<p>Describes one or more of your virtual private gateways.</p> <p>For more information about virtual private gateways, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html">AWS Managed VPN Connections</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeVpnGateways|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your virtual private gateways.</p> <p>For more information about virtual private gateways, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html">AWS Managed VPN Connections</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeVpnGateways|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified virtual private gateway. We recommend that before you delete a virtual private gateway, you detach it from the VPC and delete the VPN connection. Note that you don't need to delete the virtual private gateway if you plan to delete and recreate the VPN connection between your VPC and your network.</p>|DeleteVpnGateway|
