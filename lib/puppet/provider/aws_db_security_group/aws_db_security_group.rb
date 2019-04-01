require 'puppet/resource_api'


require 'aws-sdk-rds'






# AwsDbSecurityGroup class
class Puppet::Provider::AwsDbSecurityGroup::AwsDbSecurityGroup
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client        = Aws::RDS::Client.new(region: region)
    all_instances = []
    client.describe_db_security_groups.each do |response|
      response.db_security_groups.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances

  end

  def instance_to_hash(instance)
    db_security_group_arn = instance.respond_to?(:db_security_group_arn) ? (instance.db_security_group_arn.respond_to?(:to_hash) ? instance.db_security_group_arn.to_hash : instance.db_security_group_arn) : nil
    db_security_group_description = instance.respond_to?(:db_security_group_description) ? (instance.db_security_group_description.respond_to?(:to_hash) ? instance.db_security_group_description.to_hash : instance.db_security_group_description) : nil
    db_security_group_name = instance.respond_to?(:db_security_group_name) ? (instance.db_security_group_name.respond_to?(:to_hash) ? instance.db_security_group_name.to_hash : instance.db_security_group_name) : nil
    ec2_security_groups = instance.respond_to?(:ec2_security_groups) ? (instance.ec2_security_groups.respond_to?(:to_hash) ? instance.ec2_security_groups.to_hash : instance.ec2_security_groups) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    ip_ranges = instance.respond_to?(:ip_ranges) ? (instance.ip_ranges.respond_to?(:to_hash) ? instance.ip_ranges.to_hash : instance.ip_ranges) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records) : nil
    owner_id = instance.respond_to?(:owner_id) ? (instance.owner_id.respond_to?(:to_hash) ? instance.owner_id.to_hash : instance.owner_id) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    db_security_group = {}
    db_security_group[:ensure] = :present
    db_security_group[:object] = instance
    db_security_group[:name] = instance.to_hash[self.namevar]
    db_security_group[:db_security_group_arn] = db_security_group_arn unless db_security_group_arn.nil?
    db_security_group[:db_security_group_description] = db_security_group_description unless db_security_group_description.nil?
    db_security_group[:db_security_group_name] = db_security_group_name unless db_security_group_name.nil?
    db_security_group[:ec2_security_groups] = ec2_security_groups unless ec2_security_groups.nil?
    db_security_group[:filters] = filters unless filters.nil?
    db_security_group[:ip_ranges] = ip_ranges unless ip_ranges.nil?
    db_security_group[:max_records] = max_records unless max_records.nil?
    db_security_group[:owner_id] = owner_id unless owner_id.nil?
    db_security_group[:tags] = tags unless tags.nil?
    db_security_group[:vpc_id] = vpc_id unless vpc_id.nil?
    db_security_group
  end

  def namevar
    :db_security_group_name
  end

  def self.namevar
    :db_security_group_name
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

      client   = Aws::RDS::Client.new(region: region)
      client.create_db_security_group(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end



  def build_hash(resource)
    db_security_group = {}
    db_security_group['db_security_group_description'] = resource[:db_security_group_description] unless resource[:db_security_group_description].nil?
    db_security_group['db_security_group_name'] = resource[:db_security_group_name] unless resource[:db_security_group_name].nil?
    db_security_group['filters'] = resource[:filters] unless resource[:filters].nil?
    db_security_group['max_records'] = resource[:max_records] unless resource[:max_records].nil?
    db_security_group['tags'] = resource[:tags] unless resource[:tags].nil?
    symbolize(db_security_group)
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
    client.delete_db_security_group(new_hash)
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
