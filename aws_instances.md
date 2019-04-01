Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## Instances



```puppet
aws_instances {
  additional_info => "additional_info (optional)",
  block_device_mappings => "BlockDeviceMappings (optional)",
  capacity_reservation_specification => $aws_capacity_reservation_specification
  client_token => "client_token (optional)",
  cpu_options => $aws_cpu_options_request
  credit_specification => $aws_credit_specification_request
  disable_api_termination => "DisableApiTermination (optional)",
  dry_run => "DryRun (optional)",
  ebs_optimized => "EbsOptimized (optional)",
  elastic_gpu_specification => "ElasticGpuSpecification (optional)",
  elastic_inference_accelerators => "ElasticInferenceAccelerators (optional)",
  filters => "Filters (optional)",
  hibernation_options => $aws_hibernation_options_request
  iam_instance_profile => $aws_iam_instance_profile_specification
  kernel_id => "kernel_id (optional)",
  image_id => "image_id (optional)",
  instance_ids => "InstanceIds (optional)",
  instance_initiated_shutdown_behavior => $aws_shutdown_behavior
  instance_market_options => $aws_instance_market_options_request
  instance_type => $aws_instance_type
  ipv6_address_count => "1234 (optional)",
  ipv6_addresses => "Ipv6Addresses (optional)",
  kernel_id => "kernel_id (optional)",
  key_name => "key_name (optional)",
  launch_template => $aws_launch_template_specification
  license_specifications => $aws_license_specification_list_request
  max_count => "1234 (optional)",
  max_results => "1234 (optional)",
  min_count => "1234 (optional)",
  monitoring => $aws_run_instances_monitoring_enabled
  network_interfaces => "NetworkInterfaces (optional)",
  next_token => "next_token (optional)",
  placement => $aws_placement
  private_ip_address => "private_ip_address (optional)",
  ramdisk_id => "ramdisk_id (optional)",
  security_group_ids => "SecurityGroupIds (optional)",
  security_groups => "SecurityGroups (optional)",
  subnet_id => "subnet_id (optional)",
  tag_specifications => "TagSpecifications (optional)",
  user_data => "user_data (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|additional_info | String | false |
|block_device_mappings | BlockDeviceMappingRequestList | false |
|capacity_reservation_specification | [CapacityReservationSpecification](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|client_token | String | false |
|cpu_options | [CpuOptionsRequest](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|credit_specification | [CreditSpecificationRequest](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|disable_api_termination | Boolean | false |
|dry_run | Boolean | false |
|ebs_optimized | Boolean | false |
|elastic_gpu_specification | ElasticGpuSpecifications | false |
|elastic_inference_accelerators | ElasticInferenceAccelerators | false |
|filters | FilterList | false |
|hibernation_options | [HibernationOptionsRequest](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|iam_instance_profile | [IamInstanceProfileSpecification](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|kernel_id | String | false |
|image_id | String | false |
|instance_ids | InstanceIdStringList | false |
|instance_initiated_shutdown_behavior | [ShutdownBehavior](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|instance_market_options | [InstanceMarketOptionsRequest](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|instance_type | [InstanceType](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|ipv6_address_count | Integer | false |
|ipv6_addresses | InstanceIpv6AddressList | false |
|kernel_id | String | false |
|key_name | String | false |
|launch_template | [LaunchTemplateSpecification](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|license_specifications | [LicenseSpecificationListRequest](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|max_count | Integer | false |
|max_results | Integer | false |
|min_count | Integer | false |
|monitoring | [RunInstancesMonitoringEnabled](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|network_interfaces | InstanceNetworkInterfaceSpecificationList | false |
|next_token | String | false |
|placement | [Placement](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|private_ip_address | String | false |
|ramdisk_id | String | false |
|security_group_ids | SecurityGroupIdStringList | false |
|security_groups | SecurityGroupStringList | false |
|subnet_id | String | false |
|tag_specifications | TagSpecificationList | false |
|user_data | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the Instances

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Launches the specified number of instances using an AMI for which you have permissions. </p> <p>You can specify a number of options, or leave the default options. The following rules apply:</p> <ul> <li> <p>[EC2-VPC] If you don't specify a subnet ID, we choose a default subnet from your default VPC for you. If you don't have a default VPC, you must specify a subnet ID in the request.</p> </li> <li> <p>[EC2-Classic] If don't specify an Availability Zone, we choose one for you.</p> </li> <li> <p>Some instance types must be launched into a VPC. If you do not have a default VPC, or if you do not specify a subnet ID, the request fails. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-vpc.html#vpc-only-instance-types">Instance Types Available Only in a VPC</a>.</p> </li> <li> <p>[EC2-VPC] All instances have a network interface with a primary private IPv4 address. If you don't specify this address, we choose one from the IPv4 range of your subnet.</p> </li> <li> <p>Not all instance types support IPv6 addresses. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html">Instance Types</a>.</p> </li> <li> <p>If you don't specify a security group ID, we use the default security group. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html">Security Groups</a>.</p> </li> <li> <p>If any of the AMIs have a product code attached for which the user has not subscribed, the request fails.</p> </li> </ul> <p>You can create a <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html">launch template</a>, which is a resource that contains the parameters to launch an instance. When you launch an instance using <a>RunInstances</a>, you can specify the launch template instead of specifying the launch parameters.</p> <p>To ensure faster instance launches, break up large requests into smaller batches. For example, create five separate launch requests for 100 instances each instead of one launch request for 500 instances.</p> <p>An instance is ready for you to use when it's in the <code>running</code> state. You can check the state of your instance using <a>DescribeInstances</a>. You can tag instances and EBS volumes during launch, after launch, or both. For more information, see <a>CreateTags</a> and <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html">Tagging Your Amazon EC2 Resources</a>.</p> <p>Linux instances have access to the public key of the key pair at boot. You can use this key to provide secure access to the instance. Amazon EC2 public images use this feature to provide secure access without passwords. For more information, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html">Key Pairs</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>For troubleshooting, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_InstanceStraightToTerminated.html">What To Do If An Instance Immediately Terminates</a>, and <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html">Troubleshooting Connecting to Your Instance</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|RunInstances|
|List - list all|`/`|POST|<p>Describes one or more of your instances.</p> <p>If you specify one or more instance IDs, Amazon EC2 returns information for those instances. If you do not specify instance IDs, Amazon EC2 returns information for all relevant instances. If you specify an instance ID that is not valid, an error is returned. If you specify an instance that you do not own, it is not included in the returned results.</p> <p>Recently terminated instances might appear in the returned results. This interval is usually less than one hour.</p> <p>If you describe instances in the rare case where an Availability Zone is experiencing a service disruption and you specify instance IDs that are in the affected zone, or do not specify any instance IDs at all, the call fails. If you describe instances and specify only instance IDs that are in an unaffected zone, the call works normally.</p>|DescribeInstances|
|List - get one|``||||
|List - get list using params|``||||
|Update|``||||
|Delete|`/`|POST|<p>Shuts down one or more instances. This operation is idempotent; if you terminate an instance more than once, each call succeeds. </p> <p>If you specify multiple instances and the request fails (for example, because of a single incorrect instance ID), none of the instances are terminated.</p> <p>Terminated instances remain visible after termination (for approximately one hour).</p> <p>By default, Amazon EC2 deletes all EBS volumes that were attached when the instance launched. Volumes attached after instance launch continue running.</p> <p>You can stop, start, and terminate EBS-backed instances. You can only terminate instance store-backed instances. What happens to an instance differs if you stop it or terminate it. For example, when you stop an instance, the root device and any other devices attached to the instance persist. When you terminate an instance, any attached EBS volumes with the <code>DeleteOnTermination</code> block device mapping parameter set to <code>true</code> are automatically deleted. For more information about the differences between stopping and terminating instances, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html">Instance Lifecycle</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>For more information about troubleshooting, see <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesShuttingDown.html">Troubleshooting Terminating Your Instance</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|TerminateInstances|
