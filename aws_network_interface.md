Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## NetworkInterface



```puppet
aws_network_interface {
  description => "description (optional)",
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  groups => "Groups (optional)",
  subnet_id => "subnet_id (optional)",
  ipv6_address_count => "1234 (optional)",
  ipv6_addresses => "Ipv6Addresses (optional)",
  max_results => "1234 (optional)",
  network_interface_id => "network_interface_id (optional)",
  network_interface_ids => "NetworkInterfaceIds (optional)",
  next_token => "next_token (optional)",
  private_ip_address => "private_ip_address (optional)",
  private_ip_addresses => "PrivateIpAddresses (optional)",
  secondary_private_ip_address_count => "1234 (optional)",
  subnet_id => "subnet_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|description | String | false |
|dry_run | Boolean | false |
|filters | FilterList | false |
|groups | SecurityGroupIdStringList | false |
|subnet_id | String | false |
|ipv6_address_count | Integer | false |
|ipv6_addresses | InstanceIpv6AddressList | false |
|max_results | Integer | false |
|network_interface_id | String | false |
|network_interface_ids | NetworkInterfaceIdList | false |
|next_token | String | false |
|private_ip_address | String | false |
|private_ip_addresses | PrivateIpAddressSpecificationList | false |
|secondary_private_ip_address_count | Integer | false |
|subnet_id | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the NetworkInterface

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a network interface in the specified subnet.</p> <p>For more information about network interfaces, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html">Elastic Network Interfaces</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|CreateNetworkInterface|
|List - list all|`/`|POST|<p>Describes one or more of your network interfaces.</p>|DescribeNetworkInterfaces|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your network interfaces.</p>|DescribeNetworkInterfaces|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified network interface. You must detach the network interface before you can delete it.</p>|DeleteNetworkInterface|
