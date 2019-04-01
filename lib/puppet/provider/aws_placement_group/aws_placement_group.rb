require 'puppet/resource_api'


require 'aws-sdk-ec2'






# AwsPlacementGroup class
class Puppet::Provider::AwsPlacementGroup::AwsPlacementGroup
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)
    all_instances = []
    client.describe_placement_groups.each do |response|
      response.placement_groups.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    group_name = instance.respond_to?(:group_name) ? (instance.group_name.respond_to?(:to_hash) ? instance.group_name.to_hash : instance.group_name) : nil
    group_names = instance.respond_to?(:group_names) ? (instance.group_names.respond_to?(:to_hash) ? instance.group_names.to_hash : instance.group_names) : nil
    partition_count = instance.respond_to?(:partition_count) ? (instance.partition_count.respond_to?(:to_hash) ? instance.partition_count.to_hash : instance.partition_count) : nil
    strategy = instance.respond_to?(:strategy) ? (instance.strategy.respond_to?(:to_hash) ? instance.strategy.to_hash : instance.strategy) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:group_name] = group_name unless group_name.nil?
    hash[:group_names] = group_names unless group_names.nil?
    hash[:partition_count] = partition_count unless partition_count.nil?
    hash[:strategy] = strategy unless strategy.nil?
    hash
  end
  def namevar
    :group_name
  end

  def self.namevar
    :group_name
  end

  def name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end

  def name_from_tag(instance)
    tags = instance.respond_to?(:tags) ? instance.tags : nil
    name = tags.find { |x| x.key == 'Name' } unless tags.nil?
    name.value unless name.nil?
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

  def region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def create(context, name, should)
    context.creating(name) do
      new_hash = symbolize(build_hash(should))

      client = Aws::EC2::Client.new(region: region)
      response = client.create_placement_group(new_hash)
      res = response.respond_to?(:placement_group) ? response.placement_group : response
      client.create_tags(
        resources: [res.to_hash[namevar]],
        tags: [{ key: 'Name', value: name }],
      )
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end



  def build_hash(resource)
    placement_group = {}
    placement_group['dry_run'] = resource[:dry_run] unless resource[:dry_run].nil?
    placement_group['filters'] = resource[:filters] unless resource[:filters].nil?
    placement_group['group_name'] = resource[:group_name] unless resource[:group_name].nil?
    placement_group['group_names'] = resource[:group_names] unless resource[:group_names].nil?
    placement_group['group_name'] = resource[:group_name] unless resource[:group_name].nil?
    placement_group['partition_count'] = resource[:partition_count] unless resource[:partition_count].nil?
    placement_group['strategy'] = resource[:strategy] unless resource[:strategy].nil?
    placement_group
  end

  def self.build_key_values
    key_values = {}

    key_values
  end

  def destroy
    delete(resource)
  end

  def delete(should)
    client = Aws::EC2::Client.new(region: region)
    myhash = {}
    @property_hash.each do |response|
      if response[:name] == should[:name]
        myhash = response
      end
    end
    client.delete_placement_group(namevar => myhash[namevar])
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
