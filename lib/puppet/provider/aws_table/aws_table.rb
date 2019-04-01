require 'puppet/resource_api'


require 'aws-sdk-dynamodb'






# AwsTable class
class Puppet::Provider::AwsTable::AwsTable
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)


    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client = Aws::DynamoDB::Client.new(region: region)

    all_tables = []
    client.list_tables.table_names.each do |response|
      client.describe_table(namevar => response).each do |i|
        hash = instance_to_hash(i.table)
        all_tables << hash if name?(hash)
      end
    end
    @property_hash = all_tables
    context.debug("Completed get, returning hash #{all_tables}")
    all_tables

  end

  def instance_to_hash(instance)
    attribute_definitions = instance.respond_to?(:attribute_definitions) ? (instance.attribute_definitions.respond_to?(:to_hash) ? instance.attribute_definitions.to_hash : instance.attribute_definitions) : nil
    billing_mode = instance.respond_to?(:billing_mode) ? (instance.billing_mode.respond_to?(:to_hash) ? instance.billing_mode.to_hash : instance.billing_mode) : nil
    billing_mode_summary = instance.respond_to?(:billing_mode_summary) ? (instance.billing_mode_summary.respond_to?(:to_hash) ? instance.billing_mode_summary.to_hash : instance.billing_mode_summary) : nil
    creation_date_time = instance.respond_to?(:creation_date_time) ? (instance.creation_date_time.respond_to?(:to_hash) ? instance.creation_date_time.to_hash : instance.creation_date_time) : nil
    global_secondary_indexes = instance.respond_to?(:global_secondary_indexes) ? (instance.global_secondary_indexes.respond_to?(:to_hash) ? instance.global_secondary_indexes.to_hash : instance.global_secondary_indexes) : nil
    item_count = instance.respond_to?(:item_count) ? (instance.item_count.respond_to?(:to_hash) ? instance.item_count.to_hash : instance.item_count) : nil
    key_schema = instance.respond_to?(:key_schema) ? (instance.key_schema.respond_to?(:to_hash) ? instance.key_schema.to_hash : instance.key_schema) : nil
    latest_stream_arn = instance.respond_to?(:latest_stream_arn) ? (instance.latest_stream_arn.respond_to?(:to_hash) ? instance.latest_stream_arn.to_hash : instance.latest_stream_arn) : nil
    latest_stream_label = instance.respond_to?(:latest_stream_label) ? (instance.latest_stream_label.respond_to?(:to_hash) ? instance.latest_stream_label.to_hash : instance.latest_stream_label) : nil
    local_secondary_indexes = instance.respond_to?(:local_secondary_indexes) ? (instance.local_secondary_indexes.respond_to?(:to_hash) ? instance.local_secondary_indexes.to_hash : instance.local_secondary_indexes) : nil
    provisioned_throughput = instance.respond_to?(:provisioned_throughput) ? (instance.provisioned_throughput.respond_to?(:to_hash) ? instance.provisioned_throughput.to_hash : instance.provisioned_throughput) : nil
    restore_summary = instance.respond_to?(:restore_summary) ? (instance.restore_summary.respond_to?(:to_hash) ? instance.restore_summary.to_hash : instance.restore_summary) : nil
    sse_description = instance.respond_to?(:sse_description) ? (instance.sse_description.respond_to?(:to_hash) ? instance.sse_description.to_hash : instance.sse_description) : nil
    sse_specification = instance.respond_to?(:sse_specification) ? (instance.sse_specification.respond_to?(:to_hash) ? instance.sse_specification.to_hash : instance.sse_specification) : nil
    stream_specification = instance.respond_to?(:stream_specification) ? (instance.stream_specification.respond_to?(:to_hash) ? instance.stream_specification.to_hash : instance.stream_specification) : nil
    table_arn = instance.respond_to?(:table_arn) ? (instance.table_arn.respond_to?(:to_hash) ? instance.table_arn.to_hash : instance.table_arn) : nil
    table_id = instance.respond_to?(:table_id) ? (instance.table_id.respond_to?(:to_hash) ? instance.table_id.to_hash : instance.table_id) : nil
    table_name = instance.respond_to?(:table_name) ? (instance.table_name.respond_to?(:to_hash) ? instance.table_name.to_hash : instance.table_name) : nil
    table_size_bytes = instance.respond_to?(:table_size_bytes) ? (instance.table_size_bytes.respond_to?(:to_hash) ? instance.table_size_bytes.to_hash : instance.table_size_bytes) : nil
    table_status = instance.respond_to?(:table_status) ? (instance.table_status.respond_to?(:to_hash) ? instance.table_status.to_hash : instance.table_status) : nil

    table = {}
    table[:ensure] = :present
    table[:object] = instance
    table[:name] = instance.to_hash[self.namevar]
    table[:attribute_definitions] = attribute_definitions unless attribute_definitions.nil?
    table[:billing_mode] = billing_mode unless billing_mode.nil?
    table[:billing_mode_summary] = billing_mode_summary unless billing_mode_summary.nil?
    table[:creation_date_time] = creation_date_time unless creation_date_time.nil?
    table[:global_secondary_indexes] = global_secondary_indexes unless global_secondary_indexes.nil?
    table[:item_count] = item_count unless item_count.nil?
    table[:key_schema] = key_schema unless key_schema.nil?
    table[:latest_stream_arn] = latest_stream_arn unless latest_stream_arn.nil?
    table[:latest_stream_label] = latest_stream_label unless latest_stream_label.nil?
    table[:local_secondary_indexes] = local_secondary_indexes unless local_secondary_indexes.nil?
    table[:provisioned_throughput] = provisioned_throughput unless provisioned_throughput.nil?
    table[:restore_summary] = restore_summary unless restore_summary.nil?
    table[:sse_description] = sse_description unless sse_description.nil?
    table[:sse_specification] = sse_specification unless sse_specification.nil?
    table[:stream_specification] = stream_specification unless stream_specification.nil?
    table[:table_arn] = table_arn unless table_arn.nil?
    table[:table_id] = table_id unless table_id.nil?
    table[:table_name] = table_name unless table_name.nil?
    table[:table_size_bytes] = table_size_bytes unless table_size_bytes.nil?
    table[:table_status] = table_status unless table_status.nil?
    table
  end

  def namevar
    :table_name
  end

  def self.namevar
    :table_name
  end

  def name?(hash)
    !hash[self.namevar].nil? && !hash[self.namevar].empty?
  end

  def set(context, changes, noop: false)
    context.debug('Entered set')

    changes.each do |name, change|
      context.debug("set change with #{name} and #{change}")
      is = change.key?(:is) ? change[:is] : get(context).find { |key| key[:id] == name }
      should = change[:should]

      is = { name: name, ensure: 'absent' } if is.nil?
      should = { name: name, ensure: 'absent' } if should.nil?

      if is[:ensure].to_s == 'absent' && should[:ensure].to_s == 'present'
        create(context, name, should) unless noop
      elsif is[:ensure].to_s == 'present' && should[:ensure].to_s == 'absent'
        context.deleting(name) do
          delete(should) unless noop
        end
      elsif is[:ensure].to_s == 'absent' && should[:ensure].to_s == 'absent'
        context.failed(name, message: 'Unexpected absent to absent change')
      elsif is[:ensure].to_s == 'present' && should[:ensure].to_s == 'present'
        # if update method exists call update, else delete and recreate the resource
        context.deleting(name) do
          delete(should) unless noop
        end
        create(context, name, should) unless noop
      end
    end
  end

  def self.region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def create(context, name, should)
    context.creating(name) do
      new_hash = symbolize(build_hash(should))
      client = Aws::DynamoDB::Client.new(region: region)
      client.create_table(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end



  def build_hash(resource)
    table = {}
    table['attribute_definitions'] = resource[:attribute_definitions] unless resource[:attribute_definitions].nil?
    table['billing_mode'] = resource[:billing_mode] unless resource[:billing_mode].nil?
    table['global_secondary_indexes'] = resource[:global_secondary_indexes] unless resource[:global_secondary_indexes].nil?
    table['key_schema'] = resource[:key_schema] unless resource[:key_schema].nil?
    table['local_secondary_indexes'] = resource[:local_secondary_indexes] unless resource[:local_secondary_indexes].nil?
    table['provisioned_throughput'] = resource[:provisioned_throughput] unless resource[:provisioned_throughput].nil?
    table['sse_specification'] = resource[:sse_specification] unless resource[:sse_specification].nil?
    table['stream_specification'] = resource[:stream_specification] unless resource[:stream_specification].nil?
    table['table_name'] = resource[:table_name] unless resource[:table_name].nil?
    symbolize(table)
  end

  def self.build_key_values
    key_values = {}
    key_values
  end

  def destroy
    delete(resource)
  end

  def delete(should)
    new_hash = symbolize(build_hash(should))
    client = Aws::DynamoDB::Client.new(region: region)
    client.delete_table(namevar => new_hash[namevar])
  rescue StandardError => ex
    Puppet.alert("Exception during destroy. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def symbolize(obj)
    return obj.reduce({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_sym] = symbolize(v) }
    end if obj.is_a? Hash

    return obj.reduce([]) do |memo, v|
      memo << symbolize(v); memo
    end if obj.is_a? Array
    obj
  end
end
