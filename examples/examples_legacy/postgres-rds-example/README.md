# RDS

[Amazon Relational Database Service](http://aws.amazon.com/rds/) (Amazon RDS) is a web service that makes it easy to set up, operate, and scale a relational database in the cloud.

## How

This example creates a db security group and Postgres RDS instance.

    puppet apply rds_security.pp

You can now check to see if your security group is correct by using `puppet resource` commands:

    puppet resource aws_db_security_group rds-postgres-db_securitygroup

It should return something like this:

~~~
aws_db_security_group { 'rds-postgres-db_securitygroup':
  ensure => 'present',
  db_security_group_arn => 'arn:aws:rds:us-west-2:secgrp:rds-postgres-db_securitygroup',
  db_security_group_description => 'An RDS Security group to allow Postgres',
  db_security_group_name => 'rds-postgres-db_securitygroup',
  ec2_security_groups => [],
  ip_ranges => [],
  owner_id => '---',
  vpc_id => 'vpc-idfg',
}
~~~

When this is complete, create the RDS Postgres instance:

    puppet apply rds_postgres.pp

This can take a while to set up, but when it's complete, you should be able to access it:

~~~
psql -d postgresql -h puppetlabs-aws-postgres.cwgutxb9fmx.us-west-2.rds.amazonaws.com -U root

Password for user root: pullZstringz345
psql (9.4.0, server 9.3.5)
SSL connection (protocol: TLSv1.2, cipher: DHE-RSA-AES256-GCM-SHA384, bits: 256, compression: off)
Type "help" for help.

postgresql=> exit
~~~
