require 'json'
require 'retries'

require 'aws-sdk-ec2'


Puppet::Type.type(:aws_tags).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end

  def namevar
    :resources
  end

  # Properties

  def dry_run=(value)
    Puppet.info("dry_run setter called to change to #{value}")
    @property_flush[:dry_run] = value
  end

  def resources=(value)
    Puppet.info("resources setter called to change to #{value}")
    @property_flush[:resources] = value
  end

  def tags=(value)
    Puppet.info("tags setter called to change to #{value}")
    @property_flush[:tags] = value
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



  def self.name_from_tag(instance)
    tags = instance.respond_to?(:tags) ? instance.tags : nil
    tags = instance.respond_to?(:tag_set) ? instance.tag_set : tags
    name = tags.find { |x| x.key == 'Name' } unless tags.nil?
    name.value unless name.nil?
  end

  def self.instance_to_hash(instance)
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    resources = instance.respond_to?(:resources) ? (instance.resources.respond_to?(:to_hash) ? instance.resources.to_hash : instance.resources) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:resources] = resources unless resources.nil?
    hash[:tags] = tags unless tags.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EC2::Client.new(region: self.class.region)
    response = client.create_tags(build_hash)
    res = response.respond_to?(:tags) ? response.tags : response
    with_retries(max_tries: 5) do
      client.create_tags(
        resources: [res.to_hash[namevar]],
        tags: [{ key: 'Name', value: resource.provider.name }],
      )
    end
    @property_hash[:ensure] = :present
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
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
  end

  def build_hash
    tags = {}
    if @is_create || @is_update
      tags[:dry_run] = resource[:dry_run] unless resource[:dry_run].nil?
      tags[:resources] = resource[:resources] unless resource[:resources].nil?
      tags[:tags] = resource[:tags] unless resource[:tags].nil?
    end
    symbolize(tags)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_tags')
    client = Aws::EC2::Client.new(region: self.class.region)
    client.delete_tags(namevar => resource.provider.property_hash[namevar])
    @property_hash[:ensure] = :absent
  end


  # Shared funcs
  def exists?
    Puppet.info("Parametered Describe for resource #{name} of type <no value>")
    client = Aws::EC2::Client.new(region: self.class.region)
    response = client.describe_tags(namevar => resource.to_hash[namevar])
    res = response.respond_to?(:tags) ? response.tags : response
    @property_hash[:object] = :present
    @property_hash[namevar] = res[namevar]
    @property_hash[:object] = res
    return true
  rescue StandardError
    @property_hash[:object] = :absent
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
