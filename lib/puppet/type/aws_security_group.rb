require 'puppet/parameter/boolean'

# AWS provider type

Puppet::Type.newtype(:aws_security_group) do
  @doc = ''

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && provider.send(property) == :absent
        raise Puppet::Error, "In aws_security_group you must provide a value for #{property}"
      end
    end
  end
  newproperty(:description) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:dry_run) do
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
  newproperty(:group_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:group_ids, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:group_name) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:group_names, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:max_results) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:next_token) do
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
