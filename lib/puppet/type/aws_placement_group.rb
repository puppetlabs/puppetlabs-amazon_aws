require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_placement_group',
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
    partition_count: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    strategy: {
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
