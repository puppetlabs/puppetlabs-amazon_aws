require 'puppet/resource_api'


require 'aws-sdk-efs'





# AwsMountTarget class
class Puppet::Provider::AwsMountTarget::AwsMountTarget
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)
    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EFS::Client.new(region: region)
    all_instances = []

    client.describe_file_systems.each do |fs|
      fs.file_systems.each do |f|
        client.describe_mount_targets(file_system_id: f[:file_system_id]).each do |response|
          response.mount_targets.each do |i|
            hash = instance_to_hash(i)
            all_instances << hash if name?(hash)
          end
        end
      end
    end

    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    file_system_id = instance.respond_to?(:file_system_id) ? (instance.file_system_id.respond_to?(:to_hash) ? instance.file_system_id.to_hash : instance.file_system_id) : nil
    ip_address = instance.respond_to?(:ip_address) ? (instance.ip_address.respond_to?(:to_hash) ? instance.ip_address.to_hash : instance.ip_address) : nil
    max_items = instance.respond_to?(:max_items) ? (instance.max_items.respond_to?(:to_hash) ? instance.max_items.to_hash : instance.max_items) : nil
    mount_target_id = instance.respond_to?(:mount_target_id) ? (instance.mount_target_id.respond_to?(:to_hash) ? instance.mount_target_id.to_hash : instance.mount_target_id) : nil
    security_groups = instance.respond_to?(:security_groups) ? (instance.security_groups.respond_to?(:to_hash) ? instance.security_groups.to_hash : instance.security_groups) : nil
    subnet_id = instance.respond_to?(:subnet_id) ? (instance.subnet_id.respond_to?(:to_hash) ? instance.subnet_id.to_hash : instance.subnet_id) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance

    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:file_system_id] = file_system_id unless file_system_id.nil?
    hash[:ip_address] = ip_address unless ip_address.nil?
    hash[:max_items] = max_items unless max_items.nil?
    hash[:mount_target_id] = mount_target_id unless mount_target_id.nil?
    hash[:security_groups] = security_groups unless security_groups.nil?
    hash[:subnet_id] = subnet_id unless subnet_id.nil?
    hash
  end

  def namevar
    :mount_target_id
  end

  def name?(hash)
    !hash[namevar].nil? && !hash[namevar].empty?
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
      client = Aws::EFS::Client.new(region: region)
      client.create_mount_target(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end



  def build_hash(resource)
    mount_target = {}
    mount_target['file_system_id'] = resource[:file_system_id] unless resource[:file_system_id].nil?
    mount_target['file_system_id'] = resource[:file_system_id] unless resource[:file_system_id].nil?
    mount_target['ip_address'] = resource[:ip_address] unless resource[:ip_address].nil?
    mount_target['max_items'] = resource[:max_items] unless resource[:max_items].nil?
    mount_target['mount_target_id'] = resource[:mount_target_id] unless resource[:mount_target_id].nil?
    mount_target['security_groups'] = resource[:security_groups] unless resource[:security_groups].nil?
    mount_target['subnet_id'] = resource[:subnet_id] unless resource[:subnet_id].nil?
    mount_target
  end

  def build_key_values
    key_values = {}

    key_values
  end

  def destroy
    delete(resource)
  end

  def delete(should)
    client = Aws::EFS::Client.new(region: region)
    myhash = {}
    @property_hash.each do |response|
      if response[:name] == should[:name]
        myhash = response
      end
    end
    client.delete_mount_target(namevar => myhash[namevar])
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
