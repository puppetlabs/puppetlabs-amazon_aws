require 'json'
require 'retries'

require 'aws-sdk-efs'

Puppet::Type.type(:aws_file_system).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end

  # EFS properties
  def namevar
    :file_system_id
  end

  def creation_token=(value)
    Puppet.info("creation_token setter called to change to #{value}")
    @property_flush[:creation_token] = value
  end

  def encrypted=(value)
    Puppet.info("encrypted setter called to change to #{value}")
    @property_flush[:encrypted] = value
  end

  def file_system_id=(value)
    Puppet.info("file_system_id setter called to change to #{value}")
    @property_flush[:file_system_id] = value
  end

  def kms_key_id=(value)
    Puppet.info("kms_key_id setter called to change to #{value}")
    @property_flush[:kms_key_id] = value
  end

  def max_items=(value)
    Puppet.info("max_items setter called to change to #{value}")
    @property_flush[:max_items] = value
  end

  def performance_mode=(value)
    Puppet.info("performance_mode setter called to change to #{value}")
    @property_flush[:performance_mode] = value
  end

  def provisioned_throughput_in_mibps=(value)
    Puppet.info("provisioned_throughput_in_mibps setter called to change to #{value}")
    @property_flush[:provisioned_throughput_in_mibps] = value
  end

  def throughput_mode=(value)
    Puppet.info("throughput_mode setter called to change to #{value}")
    @property_flush[:throughput_mode] = value
  end

  def timestamp=(value)
    Puppet.info("timestamp setter called to change to #{value}")
    @property_flush[:timestamp] = value
  end

  def value=(value)
    Puppet.info("value setter called to change to #{value}")
    @property_flush[:value] = value
  end


  def name=(value)
    Puppet.info("name setter called to change to #{value}")
    @property_flush[:name] = value
  end

  def self.region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def self.name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end
  def self.instances
    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EFS::Client.new(region: region)

    all_instances = []
    client.describe_file_systems.each do |response|
      response.file_systems.each do |i|
        hash = instance_to_hash(i)
        all_instances << new(hash) if name?(hash)
      end
    end
    all_instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if (resource = (resources.find { |k, _| k.casecmp(prov.name).zero? } || [])[1])
        resource.provider = prov
      end
    end
  end

  def self.instance_to_hash(instance)
    creation_token = instance.respond_to?(:creation_token) ? (instance.creation_token.respond_to?(:to_hash) ? instance.creation_token.to_hash : instance.creation_token) : nil
    encrypted = instance.respond_to?(:encrypted) ? (instance.encrypted.respond_to?(:to_hash) ? instance.encrypted.to_hash : instance.encrypted) : nil
    file_system_id = instance.respond_to?(:file_system_id) ? (instance.file_system_id.respond_to?(:to_hash) ? instance.file_system_id.to_hash : instance.file_system_id) : nil
    kms_key_id = instance.respond_to?(:kms_key_id) ? (instance.kms_key_id.respond_to?(:to_hash) ? instance.kms_key_id.to_hash : instance.kms_key_id) : nil
    max_items = instance.respond_to?(:max_items) ? (instance.max_items.respond_to?(:to_hash) ? instance.max_items.to_hash : instance.max_items) : nil
    performance_mode = instance.respond_to?(:performance_mode) ? (instance.performance_mode.respond_to?(:to_hash) ? instance.performance_mode.to_hash : instance.performance_mode) : nil
    provisioned_throughput_in_mibps = instance.respond_to?(:provisioned_throughput_in_mibps) ? (instance.provisioned_throughput_in_mibps.respond_to?(:to_hash) ? instance.provisioned_throughput_in_mibps.to_hash : instance.provisioned_throughput_in_mibps) : nil
    throughput_mode = instance.respond_to?(:throughput_mode) ? (instance.throughput_mode.respond_to?(:to_hash) ? instance.throughput_mode.to_hash : instance.throughput_mode) : nil
    timestamp = instance.respond_to?(:timestamp) ? (instance.timestamp.respond_to?(:to_hash) ? instance.timestamp.to_hash : instance.timestamp) : nil
    value = instance.respond_to?(:value) ? (instance.value.respond_to?(:to_hash) ? instance.value.to_hash : instance.value) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = instance.name
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tags.empty?

    hash[:creation_token] = creation_token unless creation_token.nil?
    hash[:encrypted] = encrypted unless encrypted.nil?
    hash[:file_system_id] = file_system_id unless file_system_id.nil?
    hash[:kms_key_id] = kms_key_id unless kms_key_id.nil?
    hash[:max_items] = max_items unless max_items.nil?
    hash[:performance_mode] = performance_mode unless performance_mode.nil?
    hash[:provisioned_throughput_in_mibps] = provisioned_throughput_in_mibps unless provisioned_throughput_in_mibps.nil?
    hash[:throughput_mode] = throughput_mode unless throughput_mode.nil?
    hash[:timestamp] = timestamp unless timestamp.nil?
    hash[:value] = value unless value.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EFS::Client.new(region: self.class.region)
    response = client.create_file_system(build_hash)
    with_retries(max_tries: 5) do
      client.create_tags(
        file_system_id: response.to_hash[namevar],
        tags: [{ key: 'Name', value: resource.provider.name }],
      )
    end

    @property_hash[:ensure] = :present
  rescue StandardError => ex
    msg = ex.to_s.nil? ? ex.detail : ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{msg} and backtrace is #{ex.backtrace}")
    raise
  end

  def flush
    Puppet.info("Entered flush for resource #{name} of type <no value> - creating ? #{@is_create}, deleting ? #{@is_delete}")
    if @is_create || @is_delete
      return # we've already done the create or delete
    end
    @is_update = true
    build_hash
    Puppet.info('Calling Update on flush')
    @property_hash[:ensure] = :present
    []
  end

  def build_hash
    file_system = {}
    if @is_create || @is_update
      file_system[:creation_token] = resource[:creation_token] unless resource[:creation_token].nil?
      file_system[:encrypted] = resource[:encrypted] unless resource[:encrypted].nil?
      file_system[:file_system_id] = resource[:file_system_id] unless resource[:file_system_id].nil?
      file_system[:kms_key_id] = resource[:kms_key_id] unless resource[:kms_key_id].nil?
      file_system[:kms_key_id] = resource[:kms_key_id] unless resource[:kms_key_id].nil?
      file_system[:max_items] = resource[:max_items] unless resource[:max_items].nil?
      file_system[:performance_mode] = resource[:performance_mode] unless resource[:performance_mode].nil?
      file_system[:provisioned_throughput_in_mibps] = resource[:provisioned_throughput_in_mibps] unless resource[:provisioned_throughput_in_mibps].nil?
      file_system[:throughput_mode] = resource[:throughput_mode] unless resource[:throughput_mode].nil?
    end
    symbolize(file_system)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_file_system')
    client = Aws::EFS::Client.new(region: self.class.region)
    client.delete_file_system(namevar => @property_hash[namevar])
    @property_hash[:ensure] = :absent
  end


  # Shared funcs
  def exists?
    return_value = @property_hash[:ensure] && @property_hash[:ensure] != :absent
    Puppet.info("Checking if resource #{name} of type <no value> exists, returning #{return_value}")
    return_value
  end

  attr_reader :property_hash


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

# this is the end of the ruby class
