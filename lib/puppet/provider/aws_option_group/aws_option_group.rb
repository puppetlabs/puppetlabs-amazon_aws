require 'puppet/resource_api'


require 'aws-sdk-rds'






# AwsOptionGroup class
class Puppet::Provider::AwsOptionGroup::AwsOptionGroup
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client        = Aws::RDS::Client.new(region: region)
    all_instances = []
    client.describe_option_groups.each do |response|
      response.option_groups_list.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances

  end

  def instance_to_hash(instance)
    allows_vpc_and_non_vpc_instance_memberships = instance.respond_to?(:allows_vpc_and_non_vpc_instance_memberships) ? (instance.allows_vpc_and_non_vpc_instance_memberships.respond_to?(:to_hash) ? instance.allows_vpc_and_non_vpc_instance_memberships.to_hash : instance.allows_vpc_and_non_vpc_instance_memberships) : nil
    apply_immediately = instance.respond_to?(:apply_immediately) ? (instance.apply_immediately.respond_to?(:to_hash) ? instance.apply_immediately.to_hash : instance.apply_immediately) : nil
    engine_name = instance.respond_to?(:engine_name) ? (instance.engine_name.respond_to?(:to_hash) ? instance.engine_name.to_hash : instance.engine_name) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    major_engine_version = instance.respond_to?(:major_engine_version) ? (instance.major_engine_version.respond_to?(:to_hash) ? instance.major_engine_version.to_hash : instance.major_engine_version) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records) : nil
    option_group_arn = instance.respond_to?(:option_group_arn) ? (instance.option_group_arn.respond_to?(:to_hash) ? instance.option_group_arn.to_hash : instance.option_group_arn) : nil
    option_group_description = instance.respond_to?(:option_group_description) ? (instance.option_group_description.respond_to?(:to_hash) ? instance.option_group_description.to_hash : instance.option_group_description) : nil
    option_group_name = instance.respond_to?(:option_group_name) ? (instance.option_group_name.respond_to?(:to_hash) ? instance.option_group_name.to_hash : instance.option_group_name) : nil
    options = instance.respond_to?(:options) ? (instance.options.respond_to?(:to_hash) ? instance.options.to_hash : instance.options) : nil
    options_to_include = instance.respond_to?(:options_to_include) ? (instance.options_to_include.respond_to?(:to_hash) ? instance.options_to_include.to_hash : instance.options_to_include) : nil
    options_to_remove = instance.respond_to?(:options_to_remove) ? (instance.options_to_remove.respond_to?(:to_hash) ? instance.options_to_remove.to_hash : instance.options_to_remove) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    option_group = {}
    option_group[:ensure] = :present
    option_group[:object] = instance
    option_group[:name] = instance.to_hash[self.namevar]
    option_group[:allows_vpc_and_non_vpc_instance_memberships] = allows_vpc_and_non_vpc_instance_memberships unless allows_vpc_and_non_vpc_instance_memberships.nil?
    option_group[:apply_immediately] = apply_immediately unless apply_immediately.nil?
    option_group[:engine_name] = engine_name unless engine_name.nil?
    option_group[:filters] = filters unless filters.nil?
    option_group[:major_engine_version] = major_engine_version unless major_engine_version.nil?
    option_group[:max_records] = max_records unless max_records.nil?
    option_group[:option_group_arn] = option_group_arn unless option_group_arn.nil?
    option_group[:option_group_description] = option_group_description unless option_group_description.nil?
    option_group[:option_group_name] = option_group_name unless option_group_name.nil?
    option_group[:options] = options unless options.nil?
    option_group[:options_to_include] = options_to_include unless options_to_include.nil?
    option_group[:options_to_remove] = options_to_remove unless options_to_remove.nil?
    option_group[:tags] = tags unless tags.nil?
    option_group[:vpc_id] = vpc_id unless vpc_id.nil?
    option_group
  end

  def namevar
    :option_group_name
  end

  def self.namevar
    :option_group_name
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
      client.create_option_group(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))

      client = Aws::RDS::Client.new(region: region)
      client.modify_option_group(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    option_group = {}
    option_group['apply_immediately'] = resource[:apply_immediately] unless resource[:apply_immediately].nil?
    option_group['engine_name'] = resource[:engine_name] unless resource[:engine_name].nil?
    option_group['filters'] = resource[:filters] unless resource[:filters].nil?
    option_group['major_engine_version'] = resource[:major_engine_version] unless resource[:major_engine_version].nil?
    option_group['max_records'] = resource[:max_records] unless resource[:max_records].nil?
    option_group['option_group_description'] = resource[:option_group_description] unless resource[:option_group_description].nil?
    option_group['option_group_name'] = resource[:option_group_name] unless resource[:option_group_name].nil?
    option_group['options_to_include'] = resource[:options_to_include] unless resource[:options_to_include].nil?
    option_group['options_to_remove'] = resource[:options_to_remove] unless resource[:options_to_remove].nil?
    option_group['tags'] = resource[:tags] unless resource[:tags].nil?
    symbolize(option_group)
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
    client.delete_option_group(new_hash)
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
