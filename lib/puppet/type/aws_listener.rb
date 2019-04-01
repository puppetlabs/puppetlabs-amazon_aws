require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_listener',
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



    certificates: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    default_actions: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    listener_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    listener_arns: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    load_balancer_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    page_size: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    port: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    protocol: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    ssl_policy: {
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
