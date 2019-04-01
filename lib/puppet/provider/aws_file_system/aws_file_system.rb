require 'puppet/resource_api'


require 'aws-sdk-efs'





# AwsFileSystem class
class Puppet::Provider::AwsFileSystem::AwsFileSystem
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)
    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EFS::Client.new(region: region)
    all_instances = []

    client.describe_file_systems.each do |response|
      response.file_systems.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end

    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    creation_token = instance.respond_to?(:creation_token) ? (instance.creation_token.respond_to?(:to_hash) ? instance.creation_token.to_hash : instance.creation_token) : nil
    encrypted = instance.respond_to?(:encrypted) ? (instance.encrypted.respond_to?(:to_hash) ? instance.encrypted.to_hash : instance.encrypted) : nil
    file_system_id = instance.respond_to?(:file_system_id) ? (instance.file_system_id.respond_to?(:to_hash) ? instance.file_system_id.to_hash : instance.file_system_id) : nil
    kms_key_id = instance.respond_to?(:kms_key_id) ? (instance.kms_key_id.respond_to?(:to_hash) ? instance.kms_key_id.to_hash : instance.kms_key_id) : nil
    max_items = instance.respond_to?(:max_items) ? (instance.max_items.respond_to?(:to_hash) ? instance.max_items.to_hash : instance.max_items) : nil
    performance_mode = instance.respond_to?(:performance_mode) ? (instance.performance_mode.respond_to?(:to_hash) ? instance.performance_mode.to_hash : instance.performance_mode) : nil
    provisioned_throughput_in_mibps = instance.respond_to?(:provisioned_throughput_in_mibps) ? (instance.provisioned_throughput_in_mibps.respond_to?(:to_hash) ? instance.provisioned_throughput_in_mibps.to_hash : instance.provisioned_throughput_in_mibps) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    throughput_mode = instance.respond_to?(:throughput_mode) ? (instance.throughput_mode.respond_to?(:to_hash) ? instance.throughput_mode.to_hash : instance.throughput_mode) : nil
    timestamp = instance.respond_to?(:timestamp) ? (instance.timestamp.respond_to?(:to_hash) ? instance.timestamp.to_hash : instance.timestamp) : nil
    value = instance.respond_to?(:value) ? (instance.value.respond_to?(:to_hash) ? instance.value.to_hash : instance.value) : nil
    value_in_ia = instance.respond_to?(:value_in_ia) ? (instance.value_in_ia.respond_to?(:to_hash) ? instance.value_in_ia.to_hash : instance.value_in_ia) : nil
    value_in_standard = instance.respond_to?(:value_in_standard) ? (instance.value_in_standard.respond_to?(:to_hash) ? instance.value_in_standard.to_hash : instance.value_in_standard) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance

    hash[:name] = instance.name

    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:creation_token] = creation_token unless creation_token.nil?
    hash[:encrypted] = encrypted unless encrypted.nil?
    hash[:file_system_id] = file_system_id unless file_system_id.nil?
    hash[:kms_key_id] = kms_key_id unless kms_key_id.nil?
    hash[:max_items] = max_items unless max_items.nil?
    hash[:performance_mode] = performance_mode unless performance_mode.nil?
    hash[:provisioned_throughput_in_mibps] = provisioned_throughput_in_mibps unless provisioned_throughput_in_mibps.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:throughput_mode] = throughput_mode unless throughput_mode.nil?
    hash[:timestamp] = timestamp unless timestamp.nil?
    hash[:value] = value unless value.nil?
    hash[:value_in_ia] = value_in_ia unless value_in_ia.nil?
    hash[:value_in_standard] = value_in_standard unless value_in_standard.nil?
    hash
  end

  def namevar
    :file_system_id
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
      response = client.create_file_system(new_hash)

      client.create_tags(
        file_system_id: response.to_hash[namevar], tags: [key: 'Name', value: name],
      )
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end



  def build_hash(resource)
    file_system = {}
    file_system['creation_token'] = resource[:creation_token] unless resource[:creation_token].nil?
    file_system['encrypted'] = resource[:encrypted] unless resource[:encrypted].nil?
    file_system['file_system_id'] = resource[:file_system_id] unless resource[:file_system_id].nil?
    file_system['kms_key_id'] = resource[:kms_key_id] unless resource[:kms_key_id].nil?
    file_system['max_items'] = resource[:max_items] unless resource[:max_items].nil?
    file_system['performance_mode'] = resource[:performance_mode] unless resource[:performance_mode].nil?
    file_system['provisioned_throughput_in_mibps'] = resource[:provisioned_throughput_in_mibps] unless resource[:provisioned_throughput_in_mibps].nil?
    file_system['tags'] = resource[:tags] unless resource[:tags].nil?
    file_system['throughput_mode'] = resource[:throughput_mode] unless resource[:throughput_mode].nil?
    file_system
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
    client.delete_file_system(namevar => myhash[namevar])
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
