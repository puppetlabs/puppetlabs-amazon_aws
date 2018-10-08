#!/bin/bash

cidr="10.200.0.0/16"

bolt task run --nodes localhost amazon_aws::ec2_aws_create_vpc cidr_block=$cidr

bolt task run --nodes localhost amazon_aws::ec2_aws_describe_vpcs

#EKS Examples

#bolt task run --nodes localhost amazon_aws::eks_aws_create_cluster name=test role_arn=arn:aws:iam::747277873297:role/testcluster-eks resources_vpc_config="{:subnet_ids=>[subnet-8eb6e8d6,subnet-bdfceecb]}"
#bolt task run --nodes localhost amazon_aws::eks_aws_list_clusters
#bolt task run --nodes localhost amazon_aws::eks_aws_describe_cluster name="test"
#bolt task run --nodes localhost amazon_aws::eks_aws_delete_cluster name="test"

#StorageGateway Examples
#bolt task run --nodes localhost amazon_aws::storagegateway_aws_list_gateways
#bolt task run --nodes localhost amazon_aws::storagegateway_aws_delete_gateway gateway_arn=arn:aws:storagegateway:eu-central-1:747277873297:gateway/sgw-7905E010

#S3 Examples
#bolt task run --nodes localhost amazon_aws::s3_aws_create_bucket bucket="testBucket97e8b4a8"
#bolt task run --nodes localhost amazon_aws::s3_aws_list_buckets