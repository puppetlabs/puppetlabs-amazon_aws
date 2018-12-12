require 'puppet/parameter/boolean'

# AWS provider type

Puppet::Type.newtype(:aws_db_snapshot) do
  @doc = ''

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && provider.send(property) == :absent
        raise Puppet::Error, "In aws_db_snapshot you must provide a value for #{property}"
      end
    end
  end
  newproperty(:allocated_storage) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:availability_zone) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_instance_identifier) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:dbi_resource_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_snapshot_arn) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:db_snapshot_identifier) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:encrypted) do
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
  newproperty(:iam_database_authentication_enabled) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:include_public) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:include_shared) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:instance_create_time) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:iops) do
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
  newproperty(:license_model) do
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
  newproperty(:max_records) do
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
  newproperty(:processor_features) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:snapshot_create_time) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:snapshot_type) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:source_db_snapshot_identifier) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:source_region) do
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
  newproperty(:storage_type) do
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
  newproperty(:tde_credential_arn) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:timezone) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:vpc_id) do
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
