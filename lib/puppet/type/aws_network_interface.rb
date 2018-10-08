require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_network_interface) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_network_interface you must provide a value for #{property}"
      end
    end
  end
  newproperty(:association) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:attachment) do
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
  newproperty(:description) do
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
  newproperty(:groups, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:interface_type) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:ipv6_address_count) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:ipv6_addresses, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:mac_address) do
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
  newproperty(:network_interface_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:network_interface_ids, :array_matching => :all) do
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
  newproperty(:owner_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:private_dns_name) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:private_ip_address) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:private_ip_addresses, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:requester_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:requester_managed) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:secondary_private_ip_address_count) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:source_dest_check) do
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
  newproperty(:subnet_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:tag_set) do
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
