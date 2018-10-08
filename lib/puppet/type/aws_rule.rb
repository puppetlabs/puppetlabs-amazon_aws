require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_rule) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_rule you must provide a value for #{property}"
      end
    end
  end
  newproperty(:actions, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:conditions, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:listener_arn) do
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
  newproperty(:priority) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:rule_arn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:rule_arns, :array_matching => :all) do
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
