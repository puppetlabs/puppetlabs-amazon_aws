$vpc_name = 'your_vpc'
$cidr_block="10.9.0.0/16"

aws_vpc { $vpc_name:
  ensure        => present,
  name => $vpc_name,
  cidr_block => $cidr_block,
}