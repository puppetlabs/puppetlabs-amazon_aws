require 'puppet/resource_api'


require 'aws-sdk-rds'






# AwsDbSubnetGroup class
class Puppet::Provider::AwsDbSubnetGroup::AwsDbSubnetGroup
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client        = Aws::RDS::Client.new(region: region)
    all_instances = []
    client.describe_db_subnet_groups.each do |response|
      response.db_subnet_groups.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances

  end

  def instance_to_hash(instance)
    db_subnet_group_arn = instance.respond_to?(:db_subnet_group_arn) ? (instance.db_subnet_group_arn.respond_to?(:to_hash) ? instance.db_subnet_group_arn.to_hash : instance.db_subnet_group_arn) : nil
    db_subnet_group_description = instance.respond_to?(:db_subnet_group_description) ? (instance.db_subnet_group_description.respond_to?(:to_hash) ? instance.db_subnet_group_description.to_hash : instance.db_subnet_group_description) : nil
    db_subnet_group_name = instance.respond_to?(:db_subnet_group_name) ? (instance.db_subnet_group_name.respond_to?(:to_hash) ? instance.db_subnet_group_name.to_hash : instance.db_subnet_group_name) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records) : nil
    subnet_group_status = instance.respond_to?(:subnet_group_status) ? (instance.subnet_group_status.respond_to?(:to_hash) ? instance.subnet_group_status.to_hash : instance.subnet_group_status) : nil
    subnet_ids = instance.respond_to?(:subnet_ids) ? (instance.subnet_ids.respond_to?(:to_hash) ? instance.subnet_ids.to_hash : instance.subnet_ids) : nil
    subnets = instance.respond_to?(:subnets) ? (instance.subnets.respond_to?(:to_hash) ? instance.subnets.to_hash : instance.subnets) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    db_subnet_group = {}
    db_subnet_group[:ensure] = :present
    db_subnet_group[:object] = instance
    db_subnet_group[:name] = instance.to_hash[self.namevar]
    db_subnet_group[:db_subnet_group_arn] = db_subnet_group_arn unless db_subnet_group_arn.nil?
    db_subnet_group[:db_subnet_group_description] = db_subnet_group_description unless db_subnet_group_description.nil?
    db_subnet_group[:db_subnet_group_name] = db_subnet_group_name unless db_subnet_group_name.nil?
    db_subnet_group[:filters] = filters unless filters.nil?
    db_subnet_group[:max_records] = max_records unless max_records.nil?
    db_subnet_group[:subnet_group_status] = subnet_group_status unless subnet_group_status.nil?
    db_subnet_group[:subnet_ids] = subnet_ids unless subnet_ids.nil?
    db_subnet_group[:subnets] = subnets unless subnets.nil?
    db_subnet_group[:tags] = tags unless tags.nil?
    db_subnet_group[:vpc_id] = vpc_id unless vpc_id.nil?
    db_subnet_group
  end

  def namevar
    :db_subnet_group_name
  end

  def self.namevar
    :db_subnet_group_name
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
      client.create_db_subnet_group(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))

      client = Aws::RDS::Client.new(region: region)
      client.modify_db_subnet_group(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    db_subnet_group = {}
    db_subnet_group['db_subnet_group_description'] = resource[:db_subnet_group_description] unless resource[:db_subnet_group_description].nil?
    db_subnet_group['db_subnet_group_name'] = resource[:db_subnet_group_name] unless resource[:db_subnet_group_name].nil?
    db_subnet_group['filters'] = resource[:filters] unless resource[:filters].nil?
    db_subnet_group['max_records'] = resource[:max_records] unless resource[:max_records].nil?
    db_subnet_group['subnet_ids'] = resource[:subnet_ids] unless resource[:subnet_ids].nil?
    db_subnet_group['tags'] = resource[:tags] unless resource[:tags].nil?
    symbolize(db_subnet_group)
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
    client.delete_db_subnet_group(new_hash)
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
