aws_security_group { 'test-sg':
  ensure      => 'present',
  description => 'big desc',
  group_name  => 'test-sg',
}
