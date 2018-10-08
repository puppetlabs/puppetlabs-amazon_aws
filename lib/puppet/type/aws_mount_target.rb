require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_mount_target) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_mount_target you must provide a value for #{property}"
      end
    end
  end
  newproperty(:file_system_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:ip_address, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:max_items, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:mount_target_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:security_groups, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:subnet_id) do
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
