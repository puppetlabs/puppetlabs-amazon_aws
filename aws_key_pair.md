Document: "ec2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/ec2/2016-11-15/api-2.json")

## KeyPair



```puppet
aws_key_pair {
  dry_run => "DryRun (optional)",
  filters => "Filters (optional)",
  key_name => "key_name (optional)",
  key_names => "KeyNames (optional)",
  key_name => "key_name (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|dry_run | Boolean | false |
|filters | FilterList | false |
|key_name | String | false |
|key_names | KeyNameStringList | false |
|key_name | String | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the KeyPair

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a 2048-bit RSA key pair with the specified name. Amazon EC2 stores the public key and displays the private key for you to save to a file. The private key is returned as an unencrypted PEM encoded PKCS#1 private key. If a key with the specified name already exists, Amazon EC2 returns an error.</p> <p>You can have up to five thousand key pairs per region.</p> <p>The key pair returned to you is available only in the region in which you create it. If you prefer, you can create your own key pair using a third-party tool and upload it to any region using <a>ImportKeyPair</a>.</p> <p>For more information, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html">Key Pairs</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|CreateKeyPair|
|List - list all|`/`|POST|<p>Describes one or more of your key pairs.</p> <p>For more information about key pairs, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html">Key Pairs</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DescribeKeyPairs|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes one or more of your key pairs.</p> <p>For more information about key pairs, see <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html">Key Pairs</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>|DescribeKeyPairs|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified key pair, by removing the public key from Amazon EC2.</p>|DeleteKeyPair|
