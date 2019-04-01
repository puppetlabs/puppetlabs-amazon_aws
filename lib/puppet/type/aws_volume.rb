require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_volume',
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



    availability_zone: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    dry_run: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    encrypted: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    end_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    filters: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    iops: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    kms_key_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_results: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    modification_state: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    next_token: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    original_iops: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    original_size: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    original_volume_type: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    progress: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    size: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    snapshot_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    start_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    status_message: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tag_specifications: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    target_iops: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    target_size: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    target_volume_type: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    volume_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    volume_ids: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    volume_type: {
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
