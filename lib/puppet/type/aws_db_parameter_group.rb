require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_db_parameter_group',
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



    db_parameter_group_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_parameter_group_family: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_parameter_group_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    description: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    filters: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_records: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    parameters: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tags: {
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
