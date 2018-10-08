require 'puppet/parameter/boolean'

Puppet::Type.newtype(:aws_instances) do
  @doc = ""

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && self.provider.send(property) == :absent
        raise Puppet::Error, "In aws_instances you must provide a value for #{property}"
      end
    end
  end
  newproperty(:additional_info) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:block_device_mappings, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:client_token) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:cpu_options) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:credit_specification) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:disable_api_termination) do
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
  newproperty(:ebs_optimized) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:elastic_gpu_specification, :array_matching => :all) do
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
  newproperty(:iam_instance_profile) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:image_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:instance_ids, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:instance_initiated_shutdown_behavior) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:instance_market_options) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:instance_type) do
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
  newproperty(:kernel_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:key_name) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:launch_template) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:max_count) do
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
  newproperty(:min_count) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:monitoring) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:network_interfaces, :array_matching => :all) do
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
  newproperty(:placement) do
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
  newproperty(:ramdisk_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:security_group_ids, :array_matching => :all) do
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
  newproperty(:subnet_id) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:tag_specifications, :array_matching => :all) do
    desc ""
    validate do |value|
      true
    end
  end
  newproperty(:user_data) do
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
