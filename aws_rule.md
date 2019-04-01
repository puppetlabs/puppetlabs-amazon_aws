Document: "elasticloadbalancingv2"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/elasticloadbalancingv2/2015-12-01/api-2.json")

## Rule



```puppet
aws_rule {
  actions => "Actions (optional)",
  conditions => "Conditions (optional)",
  listener_arn => $aws_listener_arn
  page_size => $aws_page_size
  priority => $aws_rule_priority
  rule_arn => $aws_rule_arn
  rule_arns => "RuleArns (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|actions | Actions | false |
|conditions | RuleConditionList | false |
|listener_arn | [ListenerArn](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|page_size | [PageSize](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|priority | [RulePriority](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|rule_arn | [RuleArn](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/) | false |
|rule_arns | RuleArns | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the Rule

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a rule for the specified listener. The listener must be associated with an Application Load Balancer.</p> <p>Rules are evaluated in priority order, from the lowest value to the highest value. When the conditions for a rule are met, its actions are performed. If the conditions for no rules are met, the actions for the default rule are performed. For more information, see <a href="https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html#listener-rules">Listener Rules</a> in the <i>Application Load Balancers Guide</i>.</p> <p>To view your current rules, use <a>DescribeRules</a>. To update a rule, use <a>ModifyRule</a>. To set the priorities of your rules, use <a>SetRulePriorities</a>. To delete a rule, use <a>DeleteRule</a>.</p>|CreateRule|
|List - list all|`/`|POST|<p>Describes the specified rules or the rules for the specified listener. You must specify either a listener or one or more rules.</p>|DescribeRules|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes the specified rules or the rules for the specified listener. You must specify either a listener or one or more rules.</p>|DescribeRules|
|Update|`/`|POST|<p>Modifies the specified rule.</p> <p>Any existing properties that you do not modify retain their current values.</p> <p>To modify the actions for the default rule, use <a>ModifyListener</a>.</p>|ModifyRule|
|Delete|`/`|POST|<p>Deletes the specified rule.</p>|DeleteRule|
