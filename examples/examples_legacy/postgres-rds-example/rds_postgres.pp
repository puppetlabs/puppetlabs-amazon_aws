aws_db_instance { 'puppetlabs-aws-postgres':
  ensure               => present,
  allocated_storage    => 5,
  db_instance_class    => 'db.m3.medium',
  db_name              => 'postgresql',
  engine               => 'postgres',
  license_model        => 'postgresql-license',
  master_username      => 'root',
  master_user_password => 'pullZstringz345',
  skip_final_snapshot  => true,
  storage_type         => 'gp2',
}