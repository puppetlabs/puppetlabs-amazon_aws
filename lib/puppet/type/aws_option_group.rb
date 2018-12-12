require 'puppet/parameter/boolean'

# AWS provider type

Puppet::Type.newtype(:aws_option_group) do
  @doc = ''

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && provider.send(property) == :absent
        raise Puppet::Error, "In aws_option_group you must provide a value for #{property}"
      end
    end
  end
  newproperty(:allows_vpc_and_non_vpc_instance_memberships) do
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
  newproperty(:engine_name) do
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
  newproperty(:major_engine_version) do
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
  newproperty(:option_group_arn) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:option_group_description) do
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
  newproperty(:options) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:options_to_include, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:options_to_remove, array_matching: :all) do
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
