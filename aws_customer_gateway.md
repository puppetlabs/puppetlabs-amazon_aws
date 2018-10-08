Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## CustomerGateway



```puppet
aws_customer_gateway {
  bgp_asn => "1234 (optional)",
  customer_gateway_id => "customer_gateway_id (optional)",
  customer_gateway_ids => "CustomerGatewayIds (optional)",
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  public_ip => "public_ip (optional)",
  type => $aws_gateway_type
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|bgp_asn | Integer | false |
|customer_gateway_id | String | false |
|customer_gateway_ids | CustomerGatewayIdStringList | false |
|dry_run | Boolean | false |
|filters | FilterList | false |
|public_ip | String | false |
|type | [GatewayType](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=gatewaytype) | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the CustomerGateway

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Provides information to AWS about your VPN customer gateway device. The customer gateway is the appliance at your end of the VPN connection. (The device on the AWS side of the VPN connection is the virtual private gateway.) You must provide the Internet-routable IP address of the customer gateway's external interface. The IP address must be static and may be behind a device performing network address translation (NAT).</p> <p>For devices that use Border Gateway Protocol (BGP), you can also provide the device's BGP Autonomous System Number (ASN). You can use an existing ASN assigned to your network. If you don't have an ASN already, you can use a private ASN (in the 64512 - 65534 range).</p> <note> <p>Amazon EC2 supports all 2-byte ASN numbers in the range of 1 - 65534, with the exception of 7224, which is reserved in the <code>us-east-1</code> region, and 9059, which is reserved in the <code>eu-west-1</code> region.</p> </note> <p>For more information about VPN customer gateways, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html">AWS Managed VPN Connections</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <important> <p>You cannot create more than one customer gateway with the same VPN type, IP address, and BGP ASN parameter values. If you run an identical request more than one time, the first request creates the customer gateway, and subsequent requests return information about the existing customer gateway. The subsequent requests do not create new customer gateway resources.</p> </important>|CreateCustomerGateway|
|List - list all|`/`|POST|<p>Describes one or more of your VPN customer gateways.</p> <p>For more information about VPN customer gateways, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html">AWS Managed VPN Connections</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeCustomerGateways|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your VPN customer gateways.</p> <p>For more information about VPN customer gateways, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html">AWS Managed VPN Connections</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeCustomerGateways|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified customer gateway. You must delete the VPN connection before you can delete the customer gateway.</p>|DeleteCustomerGateway|
