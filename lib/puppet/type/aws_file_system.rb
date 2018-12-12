require 'puppet/parameter/boolean'

# AWS provider type

Puppet::Type.newtype(:aws_file_system) do
  @doc = ''

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && provider.send(property) == :absent
        raise Puppet::Error, "In aws_file_system you must provide a value for #{property}"
      end
    end
  end
  newproperty(:creation_token) do
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
  newproperty(:file_system_id) do
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
  newproperty(:max_items, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:performance_mode) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:provisioned_throughput_in_mibps, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:throughput_mode) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:timestamp) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:value) do
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
