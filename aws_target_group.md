Document: "elasticloadbalancingv2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/elasticloadbalancingv2/2015-12-01/api-2.json")

## TargetGroup



```puppet
aws_target_group {
  health_check_enabled => $aws_health_check_enabled
  health_check_interval_seconds => "HealthCheckIntervalSeconds (optional)",
  health_check_path => $aws_path
  health_check_port => $aws_health_check_port
  health_check_protocol => $aws_protocol_enum
  health_check_timeout_seconds => "HealthCheckTimeoutSeconds (optional)",
  healthy_threshold_count => $aws_health_check_threshold_count
  vpc_id => $aws_vpc_id
  load_balancer_arn => $aws_load_balancer_arn
  matcher => $aws_matcher
  name => $aws_target_group_name
  names => "Names (optional)",
  page_size => $aws_page_size
  port => $aws_port
  protocol => $aws_protocol_enum
  target_group_arn => $aws_target_group_arn
  target_group_arns => "TargetGroupArns (optional)",
  target_type => $aws_target_type_enum
  unhealthy_threshold_count => $aws_health_check_threshold_count
  vpc_id => $aws_vpc_id
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|health_check_enabled | [HealthCheckEnabled](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=healthcheckenabled) | false |
|health_check_interval_seconds | HealthCheckIntervalSeconds | false |
|health_check_path | [Path](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=path) | false |
|health_check_port | [HealthCheckPort](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=healthcheckport) | false |
|health_check_protocol | [ProtocolEnum](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=protocolenum) | false |
|health_check_timeout_seconds | HealthCheckTimeoutSeconds | false |
|healthy_threshold_count | [HealthCheckThresholdCount](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=healthcheckthresholdcount) | false |
|vpc_id | [VpcId](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=vpcid) | false |
|load_balancer_arn | [LoadBalancerArn](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=loadbalancerarn) | false |
|matcher | [Matcher](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=matcher) | false |
|name | [TargetGroupName](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=targetgroupname) | false |
|names | TargetGroupNames | false |
|page_size | [PageSize](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=pagesize) | false |
|port | [Port](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=port) | false |
|protocol | [ProtocolEnum](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=protocolenum) | false |
|target_group_arn | [TargetGroupArn](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=targetgrouparn) | false |
|target_group_arns | TargetGroupArns | false |
|target_type | [TargetTypeEnum](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=targettypeenum) | false |
|unhealthy_threshold_count | [HealthCheckThresholdCount](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=healthcheckthresholdcount) | false |
|vpc_id | [VpcId](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=vpcid) | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the TargetGroup

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a target group.</p> <p>To register targets with the target group, use <a>RegisterTargets</a>. To update the health check settings for the target group, use <a>ModifyTargetGroup</a>. To monitor the health of targets in the target group, use <a>DescribeTargetHealth</a>.</p> <p>To route traffic to the targets in a target group, specify the target group in an action using <a>CreateListener</a> or <a>CreateRule</a>.</p> <p>To delete a target group, use <a>DeleteTargetGroup</a>.</p> <p>This operation is idempotent, which means that it completes at most one time. If you attempt to create multiple target groups with the same settings, each call succeeds.</p> <p>For more information, see <a href="http://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html">Target Groups for Your Application Load Balancers</a> in the <i>Application Load Balancers Guide</i> or <a href="http://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-target-groups.html">Target Groups for Your Network Load Balancers</a> in the <i>Network Load Balancers Guide</i>.</p>|CreateTargetGroup|
|List - list all|`/`|POST|<p>Describes the specified target groups or all of your target groups. By default, all target groups are described. Alternatively, you can specify one of the following to filter the results: the ARN of the load balancer, the names of one or more target groups, or the ARNs of one or more target groups.</p> <p>To describe the targets for a target group, use <a>DescribeTargetHealth</a>. To describe the attributes of a target group, use <a>DescribeTargetGroupAttributes</a>.</p>|DescribeTargetGroups|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes the specified target groups or all of your target groups. By default, all target groups are described. Alternatively, you can specify one of the following to filter the results: the ARN of the load balancer, the names of one or more target groups, or the ARNs of one or more target groups.</p> <p>To describe the targets for a target group, use <a>DescribeTargetHealth</a>. To describe the attributes of a target group, use <a>DescribeTargetGroupAttributes</a>.</p>|DescribeTargetGroups|
|Update|`/`|POST|<p>Modifies the health checks used when evaluating the health state of the targets in the specified target group.</p> <p>To monitor the health of the targets, use <a>DescribeTargetHealth</a>.</p>|ModifyTargetGroup|
|Delete|`/`|POST|<p>Deletes the specified target group.</p> <p>You can delete a target group if it is not referenced by any actions. Deleting a target group also deletes any associated health checks.</p>|DeleteTargetGroup|
