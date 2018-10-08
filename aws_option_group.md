Document: "rds"


Path: "https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis/rds/2014-10-31/api-2.json")

## OptionGroup



```puppet
aws_option_group {
  apply_immediately => "ApplyImmediately (optional)",
  engine_name => "engine_name (optional)",
  filters => "Filters (optional)",
  major_engine_version => "major_engine_version (optional)",
  max_records => "MaxRecords (optional)",
  option_group_description => "option_group_description (optional)",
  option_group_name => "option_group_name (optional)",
  options_to_include => "OptionsToInclude (optional)",
  options_to_remove => "OptionsToRemove (optional)",
  tags => "Tags (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|apply_immediately | Boolean | false |
|engine_name | String | false |
|filters | FilterList | false |
|major_engine_version | String | false |
|max_records | IntegerOptional | false |
|option_group_description | String | false |
|option_group_name | String | false |
|options_to_include | OptionConfigurationList | false |
|options_to_remove | OptionNamesList | false |
|tags | TagList | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the OptionGroup

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/`|POST|<p>Creates a new option group. You can create up to 20 option groups.</p>|CreateOptionGroup|
|List - list all|`/`|POST|<p>Describes the available option groups.</p>|DescribeOptionGroups|
|List - get one|``||||
|List - get list using params|`/`|POST|<p>Describes the available option groups.</p>|DescribeOptionGroups|
|Update|`/`|POST|<p>Modifies an existing option group.</p>|ModifyOptionGroup|
|Delete|`/`|POST|<p>Deletes an existing option group.</p>|DeleteOptionGroup|
