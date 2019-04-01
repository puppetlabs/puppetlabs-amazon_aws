require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_subnet',
  desc: <<-EOSRAPI,

  EOSRAPI
  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'Whether this apt key should be present or absent on the target system.',
    },
    name: {
      type: 'String',
      behaviour: :namevar,
      desc: '',
    },



    assign_ipv6_address_on_creation: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    availability_zone: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    availability_zone_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    available_ip_address_count: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    cidr_block: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    default_for_az: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    dry_run: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    filters: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    ipv6_cidr_block: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    ipv6_cidr_block_association_set: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    map_public_ip_on_launch: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    owner_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    state: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subnet_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subnet_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subnet_ids: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    tags: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    vpc_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },

  },

  autorequires: {
    file: '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
