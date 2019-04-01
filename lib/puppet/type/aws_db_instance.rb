require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_db_instance',
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
    allow_major_version_upgrade: {
      type: 'Optional[Boolean]',
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
    auto_minor_version_upgrade: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    availability_zone: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    backup_retention_period: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    ca_certificate_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    character_set_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    cloudwatch_logs_export_configuration: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    copy_tags_to_snapshot: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_cluster_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_instance_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_instance_class: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_instance_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_instance_port: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    db_instance_status: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    dbi_resource_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_parameter_group_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_parameter_groups: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_port_number: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    db_security_groups: {
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
    delete_automated_backups: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    deletion_protection: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    domain: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    domain_iam_role_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    domain_memberships: {
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
    enable_iam_database_authentication: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    enable_performance_insights: {
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
    engine_version: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    enhanced_monitoring_resource_arn: {
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
    iam_database_authentication_enabled: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    instance_create_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    iops: {
      type: 'Optional[String]',
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
    license_model: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    listener_endpoint: {
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
    monitoring_interval: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    monitoring_role_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    multi_az: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    new_db_instance_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    option_group_memberships: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    option_group_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    pending_modified_values: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    performance_insights_enabled: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    performance_insights_kms_key_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    performance_insights_retention_period: {
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
    processor_features: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    promotion_tier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    publicly_accessible: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    read_replica_db_cluster_identifiers: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    read_replica_db_instance_identifiers: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    read_replica_source_db_instance_identifier: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    secondary_availability_zone: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    skip_final_snapshot: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    status_infos: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    storage_encrypted: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    storage_type: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tags: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tde_credential_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tde_credential_password: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    timezone: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    use_default_processor_features: {
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
