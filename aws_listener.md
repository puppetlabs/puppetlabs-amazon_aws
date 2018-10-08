Document: "elasticloadbalancingv2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/elasticloadbalancingv2/2015-12-01/api-2.json")

## Listener



```puppet
aws_listener {
  certificates => "Certificates (optional)",
  default_actions => "DefaultActions (optional)",
  listener_arn => $aws_listener_arn
  listener_arns => "ListenerArns (optional)",
  load_balancer_arn => $aws_load_balancer_arn
  page_size => $aws_page_size
  port => $aws_port
  protocol => $aws_protocol_enum
  ssl_policy => $aws_ssl_policy_name
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|certificates | CertificateList | false |
|default_actions | Actions | false |
|listener_arn | [ListenerArn](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=listenerarn) | false |
|listener_arns | ListenerArns | false |
|load_balancer_arn | [LoadBalancerArn](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=loadbalancerarn) | false |
|page_size | [PageSize](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=pagesize) | false |
|port | [Port](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=port) | false |
|protocol | [ProtocolEnum](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=protocolenum) | false |
|ssl_policy | [SslPolicyName](https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=sslpolicyname) | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the Listener

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a listener for the specified Application Load Balancer or Network Load Balancer.</p> <p>To update a listener, use <a>ModifyListener</a>. When you are finished with a listener, you can delete it using <a>DeleteListener</a>. If you are finished with both the listener and the load balancer, you can delete them both using <a>DeleteLoadBalancer</a>.</p> <p>This operation is idempotent, which means that it completes at most one time. If you attempt to create multiple listeners with the same settings, each call succeeds.</p> <p>For more information, see <a href="http://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html">Listeners for Your Application Load Balancers</a> in the <i>Application Load Balancers Guide</i> and <a href="http://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-listeners.html">Listeners for Your Network Load Balancers</a> in the <i>Network Load Balancers Guide</i>.</p>|CreateListener|
|List - list all|`/`|POST|<p>Describes the specified listeners or the listeners for the specified Application Load Balancer or Network Load Balancer. You must specify either a load balancer or one or more listeners.</p>|DescribeListeners|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes the specified listeners or the listeners for the specified Application Load Balancer or Network Load Balancer. You must specify either a load balancer or one or more listeners.</p>|DescribeListeners|
|Update|`/`|POST|<p>Modifies the specified properties of the specified listener.</p> <p>Any properties that you do not specify retain their current values. However, changing the protocol from HTTPS to HTTP removes the security policy and SSL certificate properties. If you change the protocol from HTTP to HTTPS, you must add the security policy and server certificate.</p>|ModifyListener|
|Delete|`/`|POST|<p>Deletes the specified listener.</p> <p>Alternatively, your listener is deleted when you delete the load balancer to which it is attached, using <a>DeleteLoadBalancer</a>.</p>|DeleteListener|
