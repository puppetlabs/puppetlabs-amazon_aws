# a simple data structure defining a type and number of instances. Hardcoded as
# an example but this could obviously come from hiera or other sources.
# Change the numbers or add new types at will.
#
# Note that this example requires the future parser

$instances = {
  'web' => 4,
  'db'  => 2,
}


# Everything below here is really just implementation. If you like your defined
# types to employ recursion and you enjoy iteration in the future parser
# continue onwards

# A recursively defined function, hurray!
define create_ec2_instances($type, $count) {
  aws_instances { "${type}-${count}":
    ensure        => present,
    name          => "${type}-${count}",
    min_count     => 1,
    max_count     => 1,
    image_id      => 'ami-db710fa3',
    instance_type => 't1.micro',
  }
  $counter = inline_template('<%= @count.to_i - 1 %>')
  if $counter == '0' {
  } else {
    create_ec2_instances { "creating-${type}-${counter}":
      type  => $type,
      count => $counter,
    }
  }
}

each($instances) |$type, $count| {
  aws_security_group { "${type}-sg":
    ensure      => present,
    name        => "${type}-sg",
    group_name  => "${type}-sg",
    description => "Security group for ${type} instances",
  }
  create_ec2_instances { "creating-${type}-${counter}":
    type  => $type,
    count => $count
  }
}

