require 'puppet/parameter/boolean'

# AWS provider type

Puppet::Type.newtype(:aws_vpc) do
  @doc = ''

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && provider.send(property) == :absent
        raise Puppet::Error, "In aws_vpc you must provide a value for #{property}"
      end
    end
  end
  newproperty(:amazon_provided_ipv6_cidr_block) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:cidr_block) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:cidr_block_association_set) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:dhcp_options_id) do
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
  newproperty(:instance_tenancy) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:ipv6_cidr_block_association_set) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:is_default) do
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
  newproperty(:state) do
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
  newproperty(:vpc_ids, array_matching: :all) do
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
