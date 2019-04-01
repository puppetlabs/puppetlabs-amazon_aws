require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_rule',
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



    actions: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    conditions: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    listener_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    page_size: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    priority: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    rule_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    rule_arns: {
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
