require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_customer_gateway) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_customer_gateway you must provide a value for #{property}"
      end
    end
  end
  newproperty(:bgp_asn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:customer_gateway_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:customer_gateway_ids, :array_matching => :all) do
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
  newproperty(:ip_address) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:public_ip) do
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
  newproperty(:tags) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:type) do
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
