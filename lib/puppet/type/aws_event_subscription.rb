require 'puppet/parameter/boolean'

# AWS provider type

Puppet::Type.newtype(:aws_event_subscription) do
  @doc = ''

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && provider.send(property) == :absent
        raise Puppet::Error, "In aws_event_subscription you must provide a value for #{property}"
      end
    end
  end
  newproperty(:customer_aws_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:cust_subscription_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:enabled) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:event_categories, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:event_categories_list) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:event_subscription_arn) do
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
  newproperty(:max_records) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:sns_topic_arn) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:source_ids, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:source_ids_list) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:source_type) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:status) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:subscription_creation_time) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:subscription_name) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:tags, array_matching: :all) do
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
