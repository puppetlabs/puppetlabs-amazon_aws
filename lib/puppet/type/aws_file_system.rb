require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_file_system',
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



    creation_token: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    encrypted: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    file_system_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    kms_key_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_items: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    performance_mode: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    provisioned_throughput_in_mibps: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tags: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    throughput_mode: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    timestamp: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    value: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    value_in_ia: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    value_in_standard: {
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
