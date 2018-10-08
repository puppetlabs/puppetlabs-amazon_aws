require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_placement_group) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_placement_group you must provide a value for #{property}"
      end
    end
  end
  newproperty(:dry_run) do
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
  newproperty(:group_name) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:group_names, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:strategy) do
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
