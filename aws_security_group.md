Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## SecurityGroup



```puppet
aws_security_group {
  description => "description (optional)",
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  group_id => "group_id (optional)",
  group_ids => "GroupIds (optional)",
  group_name => "group_name (optional)",
  group_names => "GroupNames (optional)",
  max_results => "1234 (optional)",
  group_name => "group_name (optional)",
  next_token => "next_token (optional)",
  vpc_id => "vpc_id (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|description | String | false |
|dry_run | Boolean | false |
|filters | FilterList | false |
|group_id | String | false |
|group_ids | GroupIdStringList | false |
|group_name | String | false |
|group_names | GroupNameStringList | false |
|max_results | Integer | false |
|group_name | String | false |
|next_token | String | false |
|vpc_id | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the SecurityGroup

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a security group.</p> <p>A security group is for use with instances either in the EC2-Classic platform or in a specific VPC. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html">Amazon EC2 Security Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i> and <a href="https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html">Security Groups for Your VPC</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p> <important> <p>EC2-Classic: You can have up to 500 security groups.</p> <p>EC2-VPC: You can create up to 500 security groups per VPC.</p> </important> <p>When you create a security group, you specify a friendly name of your choice. You can have a security group for use in EC2-Classic with the same name as a security group for use in a VPC. However, you can't have two security groups for use in EC2-Classic with the same name or two security groups for use in a VPC with the same name.</p> <p>You have a default security group for use in EC2-Classic and a default security group for use in your VPC. If you don't specify a security group when you launch an instance, the instance is launched into the appropriate default security group. A default security group includes a default rule that grants instances unrestricted network access to each other.</p> <p>You can add or remove rules from your security groups using <a>AuthorizeSecurityGroupIngress</a>, <a>AuthorizeSecurityGroupEgress</a>, <a>RevokeSecurityGroupIngress</a>, and <a>RevokeSecurityGroupEgress</a>.</p>|CreateSecurityGroup|
|List - list all|`/`|POST|<p>Describes one or more of your security groups.</p> <p>A security group is for use with instances either in the EC2-Classic platform or in a specific VPC. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html">Amazon EC2 Security Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i> and <a href="https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html">Security Groups for Your VPC</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeSecurityGroups|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your security groups.</p> <p>A security group is for use with instances either in the EC2-Classic platform or in a specific VPC. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html">Amazon EC2 Security Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i> and <a href="https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html">Security Groups for Your VPC</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>|DescribeSecurityGroups|
|Update|``||||
|Delete|`/`|POST|<p>Deletes a security group.</p> <p>If you attempt to delete a security group that is associated with an instance, or is referenced by another security group, the operation fails with <code>InvalidGroup.InUse</code> in EC2-Classic or <code>DependencyViolation</code> in EC2-VPC.</p>|DeleteSecurityGroup|
