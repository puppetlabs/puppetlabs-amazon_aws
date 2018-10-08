Document: "elasticloadbalancingv2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/elasticloadbalancingv2/2015-12-01/api-2.json")

## LoadBalancer



```puppet
aws_load_balancer {
  ip_address_type => $aws_ip_address_type
  load_balancer_arn => $aws_load_balancer_arn
  load_balancer_arns => "LoadBalancerArns (optional)",
  name => $aws_load_balancer_name
  names => "Names (optional)",
  page_size => $aws_page_size
  scheme => $aws_load_balancer_scheme_enum
  security_groups => "SecurityGroups (optional)",
  subnet_mappings => "SubnetMappings (optional)",
  subnets => "Subnets (optional)",
  tags => "Tags (optional)",
  type => $aws_load_balancer_type_enum
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|ip_address_type | [IpAddressType](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=ipaddresstype) | false |
|load_balancer_arn | [LoadBalancerArn](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=loadbalancerarn) | false |
|load_balancer_arns | LoadBalancerArns | false |
|name | [LoadBalancerName](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=loadbalancername) | false |
|names | LoadBalancerNames | false |
|page_size | [PageSize](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=pagesize) | false |
|scheme | [LoadBalancerSchemeEnum](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=loadbalancerschemeenum) | false |
|security_groups | SecurityGroups | false |
|subnet_mappings | SubnetMappings | false |
|subnets | Subnets | false |
|tags | TagList | false |
|type | [LoadBalancerTypeEnum](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=loadbalancertypeenum) | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the LoadBalancer

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates an Application Load Balancer or a Network Load Balancer.</p> <p>When you create a load balancer, you can specify security groups, public subnets, IP address type, and tags. Otherwise, you could do so later using <a>SetSecurityGroups</a>, <a>SetSubnets</a>, <a>SetIpAddressType</a>, and <a>AddTags</a>.</p> <p>To create listeners for your load balancer, use <a>CreateListener</a>. To describe your current load balancers, see <a>DescribeLoadBalancers</a>. When you are finished with a load balancer, you can delete it using <a>DeleteLoadBalancer</a>.</p> <p>For limit information, see <a href="http://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-limits.html">Limits for Your Application Load Balancer</a> in the <i>Application Load Balancers Guide</i> and <a href="http://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-limits.html">Limits for Your Network Load Balancer</a> in the <i>Network Load Balancers Guide</i>.</p> <p>This operation is idempotent, which means that it completes at most one time. If you attempt to create multiple load balancers with the same settings, each call succeeds.</p> <p>For more information, see <a href="http://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html">Application Load Balancers</a> in the <i>Application Load Balancers Guide</i> and <a href="http://docs.aws.amazon.com/elasticloadbalancing/latest/network/network-load-balancers.html">Network Load Balancers</a> in the <i>Network Load Balancers Guide</i>.</p>|CreateLoadBalancer|
|List - list all|`/`|POST|<p>Describes the specified load balancers or all of your load balancers.</p> <p>To describe the listeners for a load balancer, use <a>DescribeListeners</a>. To describe the attributes for a load balancer, use <a>DescribeLoadBalancerAttributes</a>.</p>|DescribeLoadBalancers|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes the specified load balancers or all of your load balancers.</p> <p>To describe the listeners for a load balancer, use <a>DescribeListeners</a>. To describe the attributes for a load balancer, use <a>DescribeLoadBalancerAttributes</a>.</p>|DescribeLoadBalancers|
|Update|``||||
|Delete|`/`|POST|<p>Deletes the specified Application Load Balancer or Network Load Balancer and its attached listeners.</p> <p>You can't delete a load balancer if deletion protection is enabled. If the load balancer does not exist or has already been deleted, the call succeeds.</p> <p>Deleting a load balancer does not affect its registered targets. For example, your EC2 instances continue to run and are still registered to their target groups. If you no longer need these EC2 instances, you can stop or terminate them.</p>|DeleteLoadBalancer|
