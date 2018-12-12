plan amazon_aws::create_kubernetes_cluster(
  String[1] $cidr_block,
  String[2] $subnet_block1,
  String[3] $az1,
  String[4] $subnet_block2,
  String[5] $az2,
  String[6] $cluster_name,
) {
   $responses=run_task("amazon_aws::iam_aws_list_roles", "localhost")
   $role_list=$responses.first.value["roles"]

   $role_list.each |$role| {
      if $role["assume_role_policy_document"].match(".*eks.*") {
        $role_arn=$role["arn"]
        notice("Using role for EKS cluster")
        notice($role_arn)

        $responses=run_task("amazon_aws::ec2_aws_create_vpc", "localhost", cidr_block => $cidr_block)
        $data = $responses.first.value
        $vpc_id = $data["vpc"]["vpc_id"]

        $subnet_response=run_task("amazon_aws::ec2_aws_create_subnet","localhost", vpc_id => $vpc_id, cidr_block => $subnet_block1, availability_zone => $az1)
        $subnet1_id = $subnet_response.first.value["subnet"]["subnet_id"]

        $subnet_response2=run_task("amazon_aws::ec2_aws_create_subnet","localhost", vpc_id => $vpc_id, cidr_block => $subnet_block2, availability_zone => $az2)
        $subnet2_id = $subnet_response2.first.value["subnet"]["subnet_id"]

        notice("Creating cluster")
        $cluster_response=run_task("amazon_aws::eks_aws_create_cluster", "localhost" , name => $cluster_name, role_arn => $role_arn, resources_vpc_config => "{:subnet_ids => [$subnet1_id, $subnet2_id]}")
        notice($cluster_response)
        break()
     }
   }
}
