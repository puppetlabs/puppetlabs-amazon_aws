require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_target_group) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_target_group you must provide a value for #{property}"
      end
    end
  end
  newproperty(:health_check_interval_seconds, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:health_check_path) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:health_check_port) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:health_check_protocol) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:health_check_timeout_seconds, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:healthy_threshold_count) do
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
  newproperty(:matcher) do
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
  newproperty(:target_group_arn) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:target_group_arns, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:target_type) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:unhealthy_threshold_count) do
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
