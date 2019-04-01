require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_db_cluster_snapshot',
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



    allocated_storage: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    availability_zones: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    cluster_create_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_snapshot_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_snapshot_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    engine: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    engine_version: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    filters: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    iam_database_authentication_enabled: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    include_public: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    include_shared: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    kms_key_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    license_model: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    master_username: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_records: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    percent_progress: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    port: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    snapshot_create_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    snapshot_type: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    source_db_cluster_snapshot_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    status: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    storage_encrypted: {
      type: 'Optional[Boolean]',
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
