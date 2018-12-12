require 'puppet/parameter/boolean'

# AWS provider type

Puppet::Type.newtype(:aws_route_table) do
  @doc = ''

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && provider.send(property) == :absent
        raise Puppet::Error, "In aws_route_table you must provide a value for #{property}"
      end
    end
  end
  newproperty(:associations) do
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
  newproperty(:owner_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:propagating_vgws) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:routes) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:route_table_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:route_table_ids, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:tags) do
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
