# This example will create a Ubuntu Server 16.04 VM

$vm_name = 'your_vm'
$key_name = 'your-key-name'
$subnet_id = 'your-subnet-id'
$tag = [{ key => 'Name', value => $vm_name}, {key => lifetime , value => '1d'}]

aws_instances { $vm_name:
  ensure             => 'present',
  image_id           => 'ami-c7e0c82c',
  min_count          => 1,
  max_count          => 1,
  key_name           => $key_name,
  instance_type      => 't2.micro',
  subnet_id          => $subnet_id,
  tag_specifications => [ { resource_type => 'instance', tags => $tag } ]
}