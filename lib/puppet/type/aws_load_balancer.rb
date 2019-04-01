require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_load_balancer',
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



    ip_address_type: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    load_balancer_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    load_balancer_arns: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    names: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    page_size: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    scheme: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    security_groups: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subnet_mappings: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subnets: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    tags: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    type: {
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
