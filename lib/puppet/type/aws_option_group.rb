require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_option_group',
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



    allows_vpc_and_non_vpc_instance_memberships: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    apply_immediately: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    engine_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    filters: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    major_engine_version: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_records: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    option_group_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    option_group_description: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    option_group_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    options: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    options_to_include: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    options_to_remove: {
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

  },

  autorequires: {
    file: '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
