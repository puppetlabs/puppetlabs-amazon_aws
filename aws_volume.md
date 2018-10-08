Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## Volume



```puppet
aws_volume {
  availability_zone => "availability_zone (optional)",
  dry_run => "DryRun (optional)",
  encrypted => "Encrypted (optional)",
  filters => "Filters (optional)",
  snapshot_id => "snapshot_id (optional)",
  iops => "1234 (optional)",
  kms_key_id => "kms_key_id (optional)",
  max_results => "1234 (optional)",
  next_token => "next_token (optional)",
  size => "1234 (optional)",
  snapshot_id => "snapshot_id (optional)",
  tag_specifications => "TagSpecifications (optional)",
  volume_id => "volume_id (optional)",
  volume_ids => "VolumeIds (optional)",
  volume_type => $aws_volume_type
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|availability_zone | String | false |
|dry_run | Boolean | false |
|encrypted | Boolean | false |
|filters | FilterList | false |
|snapshot_id | String | false |
|iops | Integer | false |
|kms_key_id | String | false |
|max_results | Integer | false |
|next_token | String | false |
|size | Integer | false |
|snapshot_id | String | false |
|tag_specifications | TagSpecificationList | false |
|volume_id | String | false |
|volume_ids | VolumeIdStringList | false |
|volume_type | [VolumeType](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=volumetype) | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the Volume

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates an EBS volume that can be attached to an instance in the same Availability Zone. The volume is created in the regional endpoint that you send the HTTP request to. For more information see <a href="http://docs.aws.amazon.com/general/latest/gr/rande.html">Regions and Endpoints</a>.</p> <p>You can create a new empty volume or restore a volume from an EBS snapshot. Any AWS Marketplace product codes from the snapshot are propagated to the volume.</p> <p>You can create encrypted volumes with the <code>Encrypted</code> parameter. Encrypted volumes may only be attached to instances that support Amazon EBS encryption. Volumes that are created from encrypted snapshots are also automatically encrypted. For more information, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html">Amazon EBS Encryption</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>You can tag your volumes during creation. For more information, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html">Tagging Your Amazon EC2 Resources</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>For more information, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-creating-volume.html">Creating an Amazon EBS Volume</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|CreateVolume|
|List - list all|`/`|POST|<p>Describes the specified EBS volumes.</p> <p>If you are describing a long list of volumes, you can paginate the output to make the list more manageable. The <code>MaxResults</code> parameter sets the maximum number of results returned in a single page. If the list of results exceeds your <code>MaxResults</code> value, then that number of results is returned along with a <code>NextToken</code> value that can be passed to a subsequent <code>DescribeVolumes</code> request to retrieve the remaining results.</p> <p>For more information about EBS volumes, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumes.html">Amazon EBS Volumes</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DescribeVolumes|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes the specified EBS volumes.</p> <p>If you are describing a long list of volumes, you can paginate the output to make the list more manageable. The <code>MaxResults</code> parameter sets the maximum number of results returned in a single page. If the list of results exceeds your <code>MaxResults</code> value, then that number of results is returned along with a <code>NextToken</code> value that can be passed to a subsequent <code>DescribeVolumes</code> request to retrieve the remaining results.</p> <p>For more information about EBS volumes, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumes.html">Amazon EBS Volumes</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DescribeVolumes|
|Update|`/`|POST|<p>You can modify several parameters of an existing EBS volume, including volume size, volume type, and IOPS capacity. If your EBS volume is attached to a current-generation EC2 instance type, you may be able to apply these changes without stopping the instance or detaching the volume from it. For more information about modifying an EBS volume running Linux, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html">Modifying the Size, IOPS, or Type of an EBS Volume on Linux</a>. For more information about modifying an EBS volume running Windows, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ebs-expand-volume.html">Modifying the Size, IOPS, or Type of an EBS Volume on Windows</a>. </p> <p> When you complete a resize operation on your volume, you need to extend the volume's file-system size to take advantage of the new storage capacity. For information about extending a Linux file system, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html#recognize-expanded-volume-linux">Extending a Linux File System</a>. For information about extending a Windows file system, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ebs-expand-volume.html#recognize-expanded-volume-windows">Extending a Windows File System</a>. </p> <p> You can use CloudWatch Events to check the status of a modification to an EBS volume. For information about CloudWatch Events, see the <a href="http://docs.aws.amazon.com/AmazonCloudWatch/latest/events/">Amazon CloudWatch Events User Guide</a>. You can also track the status of a modification using the <a>DescribeVolumesModifications</a> API. For information about tracking status changes using either method, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html#monitoring_mods">Monitoring Volume Modifications</a>. </p> <p>With previous-generation instance types, resizing an EBS volume may require detaching and reattaching the volume or stopping and restarting the instance. For more information, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html">Modifying the Size, IOPS, or Type of an EBS Volume on Linux</a> and <a href="http://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ebs-expand-volume.html">Modifying the Size, IOPS, or Type of an EBS Volume on Windows</a>.</p> <p>If you reach the maximum volume modification rate per volume limit, you will need to wait at least six hours before applying further modifications to the affected EBS volume.</p>|ModifyVolume|
|Delete|`/`|POST|<p>Deletes the specified EBS volume. The volume must be in the <code>available</code> state (not attached to an instance).</p> <p>The volume can remain in the <code>deleting</code> state for several minutes.</p> <p>For more information, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-deleting-volume.html">Deleting an Amazon EBS Volume</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DeleteVolume|
