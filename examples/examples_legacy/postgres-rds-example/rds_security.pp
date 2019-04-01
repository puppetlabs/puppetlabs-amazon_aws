aws_security_group { 'rds-postgres-group':
  ensure      => 'present',
  description => 'Group for Allowing access to Postgres',
  group_name  => 'rds-postgres-group',
}

aws_db_security_group { 'rds-postgres-db_securitygroup':
  ensure                        => present,
  name                          => 'rds-postgres-db_securitygroup',
  db_security_group_name        => 'rds-postgres-db_securitygroup',
  db_security_group_description => 'An RDS Security group to allow Postgres',
}
