plan amazon_aws::create_vpc_vm(
  String[1] $cidr_block,
  String[2] $subnet_block,
  String[3] $ami,
  String[4] $instance_type,
  String[5] $key_name,
) {
   $responses=run_task("amazon_aws::ec2_aws_create_vpc", "localhost", cidr_block => $cidr_block)
   $data = $responses.first.value
   $vpc_id = $data["vpc"]["vpc_id"]

   $subnet_response=run_task("amazon_aws::ec2_aws_create_subnet","localhost", vpc_id => $vpc_id, cidr_block => $subnet_block)
   $subnet_id = $subnet_response.first.value["subnet"]["subnet_id"]

   $run_responses=run_task("amazon_aws::ec2_aws_run_instances","localhost", image_id => $ami, min_count => 1, max_count => 1, key_name => $key_name, instance_type => $instance_type, subnet_id => $subnet_id)

   notice($run_responses.first.value)
}
