require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_volume) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_volume you must provide a value for #{property}"
      end
    end
  end
  newproperty(:availability_zone) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:dry_run) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:encrypted) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:end_time) do
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
  newproperty(:max_results) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:modification_state) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:next_token) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:original_iops) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:original_size) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:original_volume_type) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:progress) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:size) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:snapshot_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:start_time) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:status_message) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:tag_specifications, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:target_iops) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:target_size) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:target_volume_type) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:volume_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:volume_ids, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:volume_type) do
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
