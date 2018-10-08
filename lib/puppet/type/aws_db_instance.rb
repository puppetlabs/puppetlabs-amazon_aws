require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_db_instance) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_db_instance you must provide a value for #{property}"
      end
    end
  end
  newproperty(:allocated_storage) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:allow_major_version_upgrade) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:apply_immediately) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:auto_minor_version_upgrade) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:availability_zone) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:backup_retention_period) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:ca_certificate_identifier) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:character_set_name) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:cloudwatch_logs_export_configuration) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:copy_tags_to_snapshot) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_cluster_identifier) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_instance_arn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_instance_class) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_instance_identifier) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_instance_port) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_instance_status) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:dbi_resource_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_name) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_parameter_group_name) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_parameter_groups) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_port_number) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_security_groups, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_subnet_group) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_subnet_group_name) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:deletion_protection) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:domain) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:domain_iam_role_name) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:domain_memberships) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:enable_cloudwatch_logs_exports, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:enabled_cloudwatch_logs_exports) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:enable_iam_database_authentication) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:enable_performance_insights) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:endpoint) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:engine) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:engine_version) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:enhanced_monitoring_resource_arn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:filters, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:final_db_snapshot_identifier) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:iam_database_authentication_enabled) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:instance_create_time) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:iops) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:kms_key_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:latest_restorable_time) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:license_model) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:master_username) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:master_user_password) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:max_records) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:monitoring_interval) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:monitoring_role_arn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:multi_az) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:new_db_instance_identifier) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:option_group_memberships) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:option_group_name) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:pending_modified_values) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:performance_insights_enabled) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:performance_insights_kms_key_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:performance_insights_retention_period) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:port) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:preferred_backup_window) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:preferred_maintenance_window) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:processor_features, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:promotion_tier) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:publicly_accessible) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:read_replica_db_cluster_identifiers) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:read_replica_db_instance_identifiers) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:read_replica_source_db_instance_identifier) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:secondary_availability_zone) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:skip_final_snapshot) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:status_infos) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:storage_encrypted) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:storage_type) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:tags, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:tde_credential_arn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:tde_credential_password) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:timezone) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:use_default_processor_features) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:vpc_security_group_ids, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:vpc_security_groups) do
    desc ""
    validate do |value|
      true
    end
  end

  newparam(:name) do
    isnamevar
    desc "The namevar for this resource in AWS"
    validate do |value|
      true
    end
  end

  newparam(:tags) do
    desc "Tags are required for all AWS resources in Puppet"
    validate do |value|
      true
    end
  end
end
