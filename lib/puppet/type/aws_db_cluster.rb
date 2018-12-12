require 'puppet/parameter/boolean'

# AWS provider type

Puppet::Type.newtype(:aws_db_cluster) do
  @doc = ''

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && provider.send(property) == :absent
        raise Puppet::Error, "In aws_db_cluster you must provide a value for #{property}"
      end
    end
  end
  newproperty(:allocated_storage) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:apply_immediately) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:associated_roles) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:availability_zones, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:backtrack_consumed_change_records) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:backtrack_window) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:backup_retention_period) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:capacity) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:character_set_name) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:clone_group_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:cloudwatch_logs_export_configuration) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:cluster_create_time) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:custom_endpoints) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:database_name) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_cluster_arn) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_cluster_identifier) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_cluster_members) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_cluster_option_group_memberships) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_cluster_parameter_group) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_cluster_parameter_group_name) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_cluster_resource_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_subnet_group) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_subnet_group_name) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:deletion_protection) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:earliest_backtrack_time) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:earliest_restorable_time) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:enable_cloudwatch_logs_exports, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:enabled_cloudwatch_logs_exports) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:enable_http_endpoint) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:enable_iam_database_authentication) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:endpoint) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:engine) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:engine_mode) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:engine_version) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:filters, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:final_db_snapshot_identifier) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:global_cluster_identifier) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:hosted_zone_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:http_endpoint_enabled) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:iam_database_authentication_enabled) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:kms_key_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:latest_restorable_time) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:master_username) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:master_user_password) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:max_records) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:multi_az) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:new_db_cluster_identifier) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:option_group_name) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:percent_progress) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:port) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:preferred_backup_window) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:preferred_maintenance_window) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:pre_signed_url) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:reader_endpoint) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:read_replica_identifiers) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:replication_source_identifier) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:scaling_configuration) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:scaling_configuration_info) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:skip_final_snapshot) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:status) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:storage_encrypted) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:tags, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:vpc_security_group_ids, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:vpc_security_groups) do
    desc ''
    validate do |x|
      true
    end
  end

  newparam(:name) do
    isnamevar
    desc 'The namevar for this resource in AWS'
    validate do |x|
      true
    end
  end

  newparam(:tags) do
    desc 'Tags are required for all AWS resources in Puppet'
    validate do |x|
      true
    end
  end
end
