Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## Tags



```puppet
aws_tags {
  dry_run => "DryRun (optional)",
  resources => "Resources (optional)",
  tags => "Tags (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|dry_run | Boolean | false |
|resources | ResourceIdList | false |
|tags | TagList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the Tags

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Adds or overwrites one or more tags for the specified Amazon EC2 resource or resources. Each resource can have a maximum of 50 tags. Each tag consists of a key and optional value. Tag keys must be unique per resource.</p> <p>For more information about tags, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html">Tagging Your Resources</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>. For more information about creating IAM policies that control users' access to resources based on tags, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-supported-iam-actions-resources.html">Supported Resource-Level Permissions for Amazon EC2 API Actions</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|CreateTags|
|List - list all|``||||
|List - get one|`/`|POST|<p>Describes one or more of the tags for your EC2 resources.</p> <p>For more information about tags, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html">Tagging Your Resources</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DescribeTags|
|List - get list using params|``||||
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified set of tags from the specified set of resources.</p> <p>To list the current tags, use <a>DescribeTags</a>. For more information about tags, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html">Tagging Your Resources</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DeleteTags|
