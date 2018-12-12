require 'puppet/parameter/boolean'

# AWS provider type

Puppet::Type.newtype(:aws_table) do
  @doc = ''

  ensurable

  validate do
    required_properties = []
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[:ensure] == :present && self[property].nil? && provider.send(property) == :absent
        raise Puppet::Error, "In aws_table you must provide a value for #{property}"
      end
    end
  end
  newproperty(:attribute_definitions, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:billing_mode) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:billing_mode_summary) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:creation_date_time) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:global_secondary_indexes, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:item_count) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:key_schema, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:latest_stream_arn) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:latest_stream_label) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:local_secondary_indexes, array_matching: :all) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:provisioned_throughput) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:restore_summary) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:sse_description) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:sse_specification) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:stream_specification) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:table_arn) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:table_id) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:table_name) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:table_size_bytes) do
    desc ''
    validate do |x|
      true
    end
  end
  newproperty(:table_status) do
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
