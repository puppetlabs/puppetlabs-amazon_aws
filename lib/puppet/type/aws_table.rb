require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_table',
  desc: <<-EOSRAPI,

  EOSRAPI
  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'Whether this apt key should be present or absent on the target system.',
    },



    attribute_definitions: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    billing_mode: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    billing_mode_summary: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    creation_date_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    global_secondary_indexes: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    item_count: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    key_schema: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    latest_stream_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    latest_stream_label: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    local_secondary_indexes: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    provisioned_throughput: {
      type: 'Struct[{read_capacity_units => Integer, write_capacity_units => Integer}]',
      desc: '',
      behaviour: :init_only,
    },
    restore_summary: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    sse_description: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    sse_specification: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    stream_specification: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    table_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    table_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    table_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :namevar,
    },
    table_size_bytes: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    table_status: {
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
