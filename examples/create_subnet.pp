$subnet_name='your_subnet'
$cidr_block='10.9.12.0/24'
$vpc_id='your_vpc_id'

aws_subnet{ $subnet_name:
  ensure     => present,
  name       => $subnet_name,
  cidr_block => $cidr_block,
  vpc_id     => $vpc_id,
}