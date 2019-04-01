require 'puppet/resource_api'


require 'aws-sdk-rds'






# AwsDbClusterParameterGroup class
class Puppet::Provider::AwsDbClusterParameterGroup::AwsDbClusterParameterGroup
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client        = Aws::RDS::Client.new(region: region)
    all_instances = []
    client.describe_db_cluster_parameter_groups.each do |response|
      response.db_cluster_parameter_groups.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances

  end

  def instance_to_hash(instance)
    db_cluster_parameter_group_arn = instance.respond_to?(:db_cluster_parameter_group_arn) ? (instance.db_cluster_parameter_group_arn.respond_to?(:to_hash) ? instance.db_cluster_parameter_group_arn.to_hash : instance.db_cluster_parameter_group_arn) : nil
    db_cluster_parameter_group_name = instance.respond_to?(:db_cluster_parameter_group_name) ? (instance.db_cluster_parameter_group_name.respond_to?(:to_hash) ? instance.db_cluster_parameter_group_name.to_hash : instance.db_cluster_parameter_group_name) : nil
    db_parameter_group_family = instance.respond_to?(:db_parameter_group_family) ? (instance.db_parameter_group_family.respond_to?(:to_hash) ? instance.db_parameter_group_family.to_hash : instance.db_parameter_group_family) : nil
    description = instance.respond_to?(:description) ? (instance.description.respond_to?(:to_hash) ? instance.description.to_hash : instance.description) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records) : nil
    parameters = instance.respond_to?(:parameters) ? (instance.parameters.respond_to?(:to_hash) ? instance.parameters.to_hash : instance.parameters) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil

    db_cluster_parameter_group = {}
    db_cluster_parameter_group[:ensure] = :present
    db_cluster_parameter_group[:object] = instance
    db_cluster_parameter_group[:name] = instance.to_hash[self.namevar]
    db_cluster_parameter_group[:db_cluster_parameter_group_arn] = db_cluster_parameter_group_arn unless db_cluster_parameter_group_arn.nil?
    db_cluster_parameter_group[:db_cluster_parameter_group_name] = db_cluster_parameter_group_name unless db_cluster_parameter_group_name.nil?
    db_cluster_parameter_group[:db_parameter_group_family] = db_parameter_group_family unless db_parameter_group_family.nil?
    db_cluster_parameter_group[:description] = description unless description.nil?
    db_cluster_parameter_group[:filters] = filters unless filters.nil?
    db_cluster_parameter_group[:max_records] = max_records unless max_records.nil?
    db_cluster_parameter_group[:parameters] = parameters unless parameters.nil?
    db_cluster_parameter_group[:tags] = tags unless tags.nil?
    db_cluster_parameter_group
  end

  def namevar
    :db_cluster_parameter_group_name
  end

  def self.namevar
    :db_cluster_parameter_group_name
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
        # if update method exists call update, else delete and recreate the resourceupdate(context, name, should)
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

      client   = Aws::RDS::Client.new(region: region)
      client.create_db_cluster_parameter_group(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))

      client = Aws::RDS::Client.new(region: region)
      client.modify_db_cluster_parameter_group(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    db_cluster_parameter_group = {}
    db_cluster_parameter_group['db_cluster_parameter_group_name'] = resource[:db_cluster_parameter_group_name] unless resource[:db_cluster_parameter_group_name].nil?
    db_cluster_parameter_group['db_parameter_group_family'] = resource[:db_parameter_group_family] unless resource[:db_parameter_group_family].nil?
    db_cluster_parameter_group['description'] = resource[:description] unless resource[:description].nil?
    db_cluster_parameter_group['filters'] = resource[:filters] unless resource[:filters].nil?
    db_cluster_parameter_group['max_records'] = resource[:max_records] unless resource[:max_records].nil?
    db_cluster_parameter_group['parameters'] = resource[:parameters] unless resource[:parameters].nil?
    db_cluster_parameter_group['tags'] = resource[:tags] unless resource[:tags].nil?
    symbolize(db_cluster_parameter_group)
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
    client = Aws::RDS::Client.new(region: region)
    client.delete_db_cluster_parameter_group(new_hash)
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
