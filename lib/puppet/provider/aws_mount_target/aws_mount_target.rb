require 'json'
require 'retries'

require 'aws-sdk-efs'

Puppet::Type.type(:aws_mount_target).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end

  # EFS properties
  def namevar
    :mount_target_id
  end

  def file_system_id=(value)
    Puppet.info("file_system_id setter called to change to #{value}")
    @property_flush[:file_system_id] = value
  end

  def ip_address=(value)
    Puppet.info("ip_address setter called to change to #{value}")
    @property_flush[:ip_address] = value
  end

  def max_items=(value)
    Puppet.info("max_items setter called to change to #{value}")
    @property_flush[:max_items] = value
  end

  def mount_target_id=(value)
    Puppet.info("mount_target_id setter called to change to #{value}")
    @property_flush[:mount_target_id] = value
  end

  def security_groups=(value)
    Puppet.info("security_groups setter called to change to #{value}")
    @property_flush[:security_groups] = value
  end

  def subnet_id=(value)
    Puppet.info("subnet_id setter called to change to #{value}")
    @property_flush[:subnet_id] = value
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

  def self.instance_to_hash(instance)
    file_system_id = instance.respond_to?(:file_system_id) ? (instance.file_system_id.respond_to?(:to_hash) ? instance.file_system_id.to_hash : instance.file_system_id) : nil
    ip_address = instance.respond_to?(:ip_address) ? (instance.ip_address.respond_to?(:to_hash) ? instance.ip_address.to_hash : instance.ip_address) : nil
    max_items = instance.respond_to?(:max_items) ? (instance.max_items.respond_to?(:to_hash) ? instance.max_items.to_hash : instance.max_items) : nil
    mount_target_id = instance.respond_to?(:mount_target_id) ? (instance.mount_target_id.respond_to?(:to_hash) ? instance.mount_target_id.to_hash : instance.mount_target_id) : nil
    security_groups = instance.respond_to?(:security_groups) ? (instance.security_groups.respond_to?(:to_hash) ? instance.security_groups.to_hash : instance.security_groups) : nil
    subnet_id = instance.respond_to?(:subnet_id) ? (instance.subnet_id.respond_to?(:to_hash) ? instance.subnet_id.to_hash : instance.subnet_id) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = instance.name
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tags.empty?

    hash[:file_system_id] = file_system_id unless file_system_id.nil?
    hash[:ip_address] = ip_address unless ip_address.nil?
    hash[:max_items] = max_items unless max_items.nil?
    hash[:mount_target_id] = mount_target_id unless mount_target_id.nil?
    hash[:security_groups] = security_groups unless security_groups.nil?
    hash[:subnet_id] = subnet_id unless subnet_id.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EFS::Client.new(region: self.class.region)
    client.create_mount_target(build_hash)
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
    mount_target = {}
    if @is_create || @is_update
      mount_target[:file_system_id] = resource[:file_system_id] unless resource[:file_system_id].nil?
      mount_target[:file_system_id] = resource[:file_system_id] unless resource[:file_system_id].nil?
      mount_target[:ip_address] = resource[:ip_address] unless resource[:ip_address].nil?
      mount_target[:max_items] = resource[:max_items] unless resource[:max_items].nil?
      mount_target[:mount_target_id] = resource[:mount_target_id] unless resource[:mount_target_id].nil?
      mount_target[:security_groups] = resource[:security_groups] unless resource[:security_groups].nil?
      mount_target[:subnet_id] = resource[:subnet_id] unless resource[:subnet_id].nil?
    end
    symbolize(mount_target)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_mount_target')
    client = Aws::EFS::Client.new(region: self.class.region)
    client.delete_mount_target(namevar => @property_hash[namevar])
    @property_hash[:ensure] = :absent
  end
  def exists?
    Puppet.info("Parametered Describe for resource #{name} of type <no value>")
    client = Aws::EFS::Client.new(region: self.class.region)
    response = client.describe_mount_targets(file_system_id: resource.to_hash[:file_system_id])

    @property_hash[:ensure] = :absent
    unless response.mount_targets.empty?
      @property_hash[:object] = response.mount_targets.first
      @property_hash[namevar] = response.mount_targets.first[namevar]
      @property_hash[:ensure] = :present
      return true
    end
    return false
  rescue StandardError
    return false
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
