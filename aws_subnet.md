Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## Subnet



```puppet
aws_subnet {
  availability_zone => "availability_zone (optional)",
  cidr_block => "cidr_block (optional)",
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  ipv6_cidr_block => "ipv6_cidr_block (optional)",
  subnet_id => "subnet_id (optional)",
  subnet_ids => "SubnetIds (optional)",
  vpc_id => "vpc_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|availability_zone | String | false |
|cidr_block | String | false |
|dry_run | Boolean | false |
|filters | FilterList | false |
|ipv6_cidr_block | String | false |
|subnet_id | String | false |
|subnet_ids | SubnetIdStringList | false |
|vpc_id | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the Subnet

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a subnet in an existing VPC.</p> <p>When you create each subnet, you provide the VPC ID and IPv4 CIDR block for the subnet. After you create a subnet, you can't change its CIDR block. The size of the subnet's IPv4 CIDR block can be the same as a VPC's IPv4 CIDR block, or a subset of a VPC's IPv4 CIDR block. If you create more than one subnet in a VPC, the subnets' CIDR blocks must not overlap. The smallest IPv4 subnet (and VPC) you can create uses a /28 netmask (16 IPv4 addresses), and the largest uses a /16 netmask (65,536 IPv4 addresses).</p> <p>If you've associated an IPv6 CIDR block with your VPC, you can create a subnet with an IPv6 CIDR block that uses a /64 prefix length. </p> <important> <p>AWS reserves both the first four and the last IPv4 address in each subnet's CIDR block. They're not available for use.</p> </important> <p>If you add more than one subnet to a VPC, they're set up in a star topology with a logical router in the middle.</p> <p>If you launch an instance in a VPC using an Amazon EBS-backed AMI, the IP address doesn't change if you stop and restart the instance (unlike a similar instance launched outside a VPC, which gets a new IP address when restarted). It's therefore possible to have a subnet with no running instances (they're all stopped), but no remaining IP addresses available.</p> <p>For more information about subnets, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Subnets.html">Your VPC and Subnets</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|CreateSubnet|
|List - list all|`/`|POST|<p>Describes one or more of your subnets.</p> <p>For more information, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Subnets.html">Your VPC and Subnets</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeSubnets|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your subnets.</p> <p>For more information, see <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Subnets.html">Your VPC and Subnets</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeSubnets|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified subnet. You must terminate all running instances in the subnet before you can delete the subnet.</p>|DeleteSubnet|
