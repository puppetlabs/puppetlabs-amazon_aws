require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_security_group',
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



    description: {
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
    group_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    group_ids: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    group_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    group_names: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_results: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    next_token: {
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
