require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_subnet) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_subnet you must provide a value for #{property}"
      end
    end
  end
  newproperty(:assign_ipv6_address_on_creation) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:availability_zone) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:available_ip_address_count) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:cidr_block) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:default_for_az) do
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
  newproperty(:filters, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:ipv6_cidr_block) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:ipv6_cidr_block_association_set) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:map_public_ip_on_launch) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:state) do
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
  newproperty(:subnet_ids, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:tags) do
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
