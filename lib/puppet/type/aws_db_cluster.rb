require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_db_cluster',
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
    apply_immediately: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    associated_roles: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    availability_zones: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    backtrack_consumed_change_records: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    backtrack_window: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    backup_retention_period: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    capacity: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    character_set_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    clone_group_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    cloudwatch_logs_export_configuration: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    cluster_create_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    copy_tags_to_snapshot: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    custom_endpoints: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    database_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_members: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_option_group_memberships: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_parameter_group: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_parameter_group_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_resource_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_subnet_group: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_subnet_group_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    deletion_protection: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    earliest_backtrack_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    earliest_restorable_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    enable_cloudwatch_logs_exports: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    enabled_cloudwatch_logs_exports: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    enable_http_endpoint: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    enable_iam_database_authentication: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    endpoint: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    engine: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    engine_mode: {
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
    final_db_snapshot_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    global_cluster_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    hosted_zone_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    http_endpoint_enabled: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    iam_database_authentication_enabled: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    kms_key_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    latest_restorable_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    master_username: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    master_user_password: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_records: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    multi_az: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    new_db_cluster_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    option_group_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    percent_progress: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    port: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    preferred_backup_window: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    preferred_maintenance_window: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    pre_signed_url: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    reader_endpoint: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    read_replica_identifiers: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    replication_source_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    scaling_configuration: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    scaling_configuration_info: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    skip_final_snapshot: {
      type: 'Optional[Boolean]',
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
    vpc_security_group_ids: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    vpc_security_groups: {
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
