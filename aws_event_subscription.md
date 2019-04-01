Document: "rds"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/rds/2014-10-31/api-2.json")

## EventSubscription



```puppet
aws_event_subscription {
  enabled => "Enabled (optional)",
  event_categories => "EventCategories (optional)",
  filters => "Filters (optional)",
  max_records => "MaxRecords (optional)",
  subscription_name => "subscription_name (optional)",
  sns_topic_arn => "sns_topic_arn (optional)",
  source_ids => "SourceIds (optional)",
  source_type => "source_type (optional)",
  subscription_name => "subscription_name (optional)",
  tags => "Tags (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|enabled | BooleanOptional | false |
|event_categories | EventCategoriesList | false |
|filters | FilterList | false |
|max_records | IntegerOptional | false |
|subscription_name | String | false |
|sns_topic_arn | String | false |
|source_ids | SourceIdsList | false |
|source_type | String | false |
|subscription_name | String | false |
|tags | TagList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the EventSubscription

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates an RDS event notification subscription. This action requires a topic ARN (Amazon Resource Name) created by either the RDS console, the SNS console, or the SNS API. To obtain an ARN with SNS, you must create a topic in Amazon SNS and subscribe to the topic. The ARN is displayed in the SNS console.</p> <p>You can specify the type of source (SourceType) you want to be notified of, provide a list of RDS sources (SourceIds) that triggers the events, and provide a list of event categories (EventCategories) for events you want to be notified of. For example, you can specify SourceType = db-instance, SourceIds = mydbinstance1, mydbinstance2 and EventCategories = Availability, Backup.</p> <p>If you specify both the SourceType and SourceIds, such as SourceType = db-instance and SourceIdentifier = myDBInstance1, you are notified of all the db-instance events for the specified source. If you specify a SourceType but do not specify a SourceIdentifier, you receive notice of the events for that source type for all your RDS sources. If you do not specify either the SourceType nor the SourceIdentifier, you are notified of events generated from all RDS sources belonging to your customer account.</p>|CreateEventSubscription|
|List - list all|`/`|POST|<p>Lists all the subscription descriptions for a customer account. The description for a subscription includes SubscriptionName, SNSTopicARN, CustomerID, SourceType, SourceID, CreationTime, and Status.</p> <p>If you specify a SubscriptionName, lists the description for that subscription.</p>|DescribeEventSubscriptions|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Lists all the subscription descriptions for a customer account. The description for a subscription includes SubscriptionName, SNSTopicARN, CustomerID, SourceType, SourceID, CreationTime, and Status.</p> <p>If you specify a SubscriptionName, lists the description for that subscription.</p>|DescribeEventSubscriptions|
|Update|`/`|POST|<p>Modifies an existing RDS event notification subscription. Note that you can't modify the source identifiers using this call; to change source identifiers for a subscription, use the <a>AddSourceIdentifierToSubscription</a> and <a>RemoveSourceIdentifierFromSubscription</a> calls.</p> <p>You can see a list of the event categories for a given SourceType in the <a href="https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html">Events</a> topic in the <i>Amazon RDS User Guide</i> or by using the <b>DescribeEventCategories</b> action.</p>|ModifyEventSubscription|
|Delete|`/`|POST|<p>Deletes an RDS event notification subscription.</p>|DeleteEventSubscription|
