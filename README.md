# Amazon AWS

#### Table of contents

1. [Description](#description)
2. [Setup](#setup)
   * [Install the module](#installing-the-module)
   * [Validate the module](#validating-the-module)
3. [Usage](#usage)
   * [Create a virtual machine and subnet](#create-a-virtual-machine-and-subnet)
   * [Run a task](#run-a-task)
   * [Examples](#examples)
4. [Reference](#reference)
   * [Resources](#resources)

## Description

Amazon AWS exposes an API for creating and managing its Infrastructure as a Service platform. By leveraging the power of Puppet code, the module enables you to interact with the AWS API to manage your AWS resources, and provides you with the ability to run Puppet tasks on target EC2 instances.

The module is generated from the [AWS API specifications](https://github.com/aws/aws-sdk-go-v2/tree/master/models/apis) and utilizes the AWS Ruby SDK. For additional information, see the [AWS SDK for Ruby documentation](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/).

## Setup

### Installing the module

Install the retries gem and the Amazon AWS Ruby SDK gem, using the same Ruby used by Puppet.

If using Puppet 4.x or higher, install the gems by running the following command:

```
/opt/puppetlabs/puppet/bin/gem install aws-sdk retries
```

Set the following environment variables specific to your AWS installation:

```bash
export AWS_ACCESS_KEY_ID=your_access_key_id
export AWS_SECRET_ACCESS_KEY=your_secret_access_key
export AWS_REGION=your_region
```

To install the module, run the following command:

```
puppet module install puppetlabs-amazon_aws
```

### Validating the module

This module is compliant with the Puppet Development Kit [(PDK)](https://puppet.com/docs/pdk/1.x/pdk.html), which provides the tool to help validate the modules's metadata, syntax, and style. When you run validations, PDK output tells you which validations it is running and notifies you of any errors or warnings it finds for each type of validation; syntax, code style, and metadata.

To run all validations against this module, run the following command:

```
pdk validate ruby
pdk validate metadata
``` 

To change validation behavior, add options flags to the command. For a complete list of command options and usage information, see the PDK command [reference](https://puppet.com/docs/pdk/1.x/pdk_reference.html#pdk-validate-command).

## Usage

### Create a virtual machine and subnet

Create an Ubuntu server v16.04:

```puppet
aws_instances { your_vm:
  ensure             => 'present',
  image_id           => 'ami-c7e0c82c',
  min_count          => 1,
  max_count          => 1,
  key_name           => your-key-name,
  instance_type      => 't2.micro',
  subnet_id          => your-subnet-id,
  tag_specifications => [ { resource_type => "instance", tags => $tag } ]
}
```

Create a subnet:

```puppet
aws_subnet{ your_subnet:
  name       => your_subnet,
  cidr_block => 10.9.12.0/24,
  vpc_id     => your_vpc_id,
  ensure     => present,
}
```

### Run a task

Create a VPC:

`bolt task run --nodes localhost amazon_aws::ec2_aws_create_vpc cidr_block=10.200.0.0/16`

### Examples

*Note:* Due to validation checks carried out by the [Resource API](https://puppet.com/docs/puppet/6.0/about_the_resource_api.html), when running any example you receive a warning that states the provider returned data that did not match the Type schema for a specific resource. This warning message can be ignored. The warning is due to mismatched data between an object, and it's property.

In the [examples](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/examples) directory you will find:

* [create_vm.pp](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/examples/create_vm.pp) to create a EC2 virtual machine.
* [create_subnet.pp](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/examples/create_subnet.pp) to create a subnet for the virtual machine.
* [task_example.sh](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/examples/task_example.sh) contains a number of sample tasks, each using [Puppet Bolt](https://puppet.com/docs/bolt/0.x/bolt.html):
  * create and describe Amazon VPCs.
  * create, list, describe, or delete an Amazon EKS cluster.
  * list or delete an AWS Storage Gateway.
  * create or list Amazon S3 buckets.

In the [legacy examples](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/examples/examples_legacy) directory are examples from the legacy module on how to create an infrastructure using this new module:

* [Auditing security groups](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/examples/examples_legacy/audit-security-groups).
* [Data driven manifests](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/examples/examples_legacy/data-driven-manifests).
* [Amazon Relational Database Service (Amazon RDS)](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/examples/examples_legacy/postgres-rds-example).

## Reference

### Resources



* [aws_table](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_table.md)

* [aws_instances](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_instances.md)
* [aws_vpc](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_vpc.md)
* [aws_egress_only_internet_gateway](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_egress_only_internet_gateway.md)
* [aws_security_group](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_security_group.md)
* [aws_tags](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_tags.md)
* [aws_customer_gateway](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_customer_gateway.md)
* [aws_internet_gateway](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_internet_gateway.md)
* [aws_key_pair](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_key_pair.md)
* [aws_vpn_gateway](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_vpn_gateway.md)
* [aws_route_table](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_route_table.md)
* [aws_placement_group](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_placement_group.md)
* [aws_volume](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_volume.md)
* [aws_network_interface](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_network_interface.md)
* [aws_subnet](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_subnet.md)

* [aws_file_system](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_file_system.md)
* [aws_mount_target](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_mount_target.md)

* [aws_load_balancer](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_load_balancer.md)
* [aws_rule](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_rule.md)
* [aws_target_group](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_target_group.md)
* [aws_listener](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_listener.md)

* [aws_db_subnet_group](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_db_subnet_group.md)
* [aws_db_cluster_parameter_group](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_db_cluster_parameter_group.md)
* [aws_db_cluster_snapshot](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_db_cluster_snapshot.md)
* [aws_db_instance](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_db_instance.md)
* [aws_option_group](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_option_group.md)
* [aws_db_security_group](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_db_security_group.md)
* [aws_db_snapshot](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_db_snapshot.md)
* [aws_db_cluster](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_db_cluster.md)
* [aws_db_parameter_group](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_db_parameter_group.md)
* [aws_event_subscription](https://github.com/puppetlabs/puppetlabs-amazon_aws/blob/master/aws_event_subscription.md)

