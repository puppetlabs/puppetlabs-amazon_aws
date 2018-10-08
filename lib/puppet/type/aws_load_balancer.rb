require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_load_balancer) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_load_balancer you must provide a value for #{property}"
      end
    end
  end
  newproperty(:ip_address_type) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:load_balancer_arn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:load_balancer_arns, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:names, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:page_size) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:scheme) do
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
  newproperty(:subnet_mappings, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:subnets, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:tags, :array_matching => :all) do
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
