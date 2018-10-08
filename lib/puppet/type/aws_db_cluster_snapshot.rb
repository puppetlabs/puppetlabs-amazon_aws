require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_db_cluster_snapshot) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_db_cluster_snapshot you must provide a value for #{property}"
      end
    end
  end
  newproperty(:allocated_storage) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:availability_zones) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:cluster_create_time) do
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
  newproperty(:db_cluster_snapshot_arn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:db_cluster_snapshot_identifier) do
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
  newproperty(:filters, :array_matching => :all) do
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
  newproperty(:include_public) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:include_shared) do
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
  newproperty(:max_records) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:percent_progress) do
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
  newproperty(:snapshot_create_time) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:snapshot_type) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:source_db_cluster_snapshot_arn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:status) do
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
  newproperty(:tags, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:vpc_id) do
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
