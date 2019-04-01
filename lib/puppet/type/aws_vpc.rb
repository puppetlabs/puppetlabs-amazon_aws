require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_vpc',
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



    amazon_provided_ipv6_cidr_block: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    cidr_block: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    cidr_block_association_set: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    dhcp_options_id: {
      type: 'Optional[String]',
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
    instance_tenancy: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    ipv6_cidr_block_association_set: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    is_default: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    max_results: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    next_token: {
      type: 'Optional[String]',
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
    vpc_ids: {
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
