Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## Vpc



```puppet
aws_vpc {
  amazon_provided_ipv6_cidr_block => "AmazonProvidedIpv6CidrBlock (optional)",
  cidr_block => "cidr_block (optional)",
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  instance_tenancy => $aws_tenancy
  vpc_id => "vpc_id (optional)",
  vpc_ids => "VpcIds (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|amazon_provided_ipv6_cidr_block | Boolean | false |
|cidr_block | String | false |
|dry_run | Boolean | false |
|filters | FilterList | false |
|instance_tenancy | [Tenancy](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=tenancy) | false |
|vpc_id | String | false |
|vpc_ids | VpcIdStringList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the Vpc

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a VPC with the specified IPv4 CIDR block. The smallest VPC you can create uses a /28 netmask (16 IPv4 addresses), and the largest uses a /16 netmask (65,536 IPv4 addresses). For more information about how large to make your VPC, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Subnets.html">Your VPC and Subnets</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <p>You can optionally request an Amazon-provided IPv6 CIDR block for the VPC. The IPv6 CIDR block uses a /56 prefix length, and is allocated from Amazon's pool of IPv6 addresses. You cannot choose the IPv6 range for your VPC.</p> <p>By default, each instance you launch in the VPC has the default DHCP options, which include only a default DNS server that we provide (AmazonProvidedDNS). For more information, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_DHCP_Options.html">DHCP Options Sets</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <p>You can specify the instance tenancy value for the VPC when you create it. You can't change this value for the VPC after you create it. For more information, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-instance.html">Dedicated Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|CreateVpc|
|List - list all|`/`|POST|<p>Describes one or more of your VPCs.</p>|DescribeVpcs|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your VPCs.</p>|DescribeVpcs|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified VPC. You must detach or delete all gateways and resources that are associated with the VPC before you can delete it. For example, you must terminate all instances running in the VPC, delete all security groups associated with the VPC (except the default one), delete all route tables associated with the VPC (except the default one), and so on.</p>|DeleteVpc|
