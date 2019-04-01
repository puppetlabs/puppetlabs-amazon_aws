require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_mount_target',
  desc: <<-EOSRAPI,

  EOSRAPI
  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'Whether this apt key should be present or absent on the target system.',
    },


    file_system_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :namevar,
    },
    ip_address: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_items: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    mount_target_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    security_groups: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subnet_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :namevar,
    },
  },

  autorequires: {
    file: '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
