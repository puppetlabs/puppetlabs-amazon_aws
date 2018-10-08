require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_listener) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_listener you must provide a value for #{property}"
      end
    end
  end
  newproperty(:certificates, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:default_actions, :array_matching => :all) do
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
  newproperty(:listener_arns, :array_matching => :all) do
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
  newproperty(:page_size) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:port) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:protocol) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:ssl_policy) do
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
