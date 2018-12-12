require 'json'
require 'retries'

require 'aws-sdk-ec2'


Puppet::Type.type(:aws_internet_gateway).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end

  def namevar
    :internet_gateway_id
  end

  # Properties

  def attachments=(value)
    Puppet.info("attachments setter called to change to #{value}")
    @property_flush[:attachments] = value
  end

  def dry_run=(value)
    Puppet.info("dry_run setter called to change to #{value}")
    @property_flush[:dry_run] = value
  end

  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end

  def internet_gateway_id=(value)
    Puppet.info("internet_gateway_id setter called to change to #{value}")
    @property_flush[:internet_gateway_id] = value
  end

  def internet_gateway_ids=(value)
    Puppet.info("internet_gateway_ids setter called to change to #{value}")
    @property_flush[:internet_gateway_ids] = value
  end

  def owner_id=(value)
    Puppet.info("owner_id setter called to change to #{value}")
    @property_flush[:owner_id] = value
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


  def self.instances
    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)

    all_instances = []
    client.describe_internet_gateways.each do |response|
      response.internet_gateways.each do |i|
        hash = instance_to_hash(i)
        all_instances << new(hash) if name?(hash)
      end
    end
    all_instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      tags = prov.respond_to?(:tags) ? prov.tags : nil
      tags = prov.respond_to?(:tag_set) ? prov.tag_set : tags
      next if tags.empty?
      name = tags.find { |x| x[:key] == 'Name' }[:value]
      if (resource = (resources.find { |k, _| k.casecmp(name).zero? } || [])[1])
        resource.provider = prov
      end
    end
  end

  def self.name_from_tag(instance)
    tags = instance.respond_to?(:tags) ? instance.tags : nil
    tags = instance.respond_to?(:tag_set) ? instance.tag_set : tags
    name = tags.find { |x| x.key == 'Name' } unless tags.nil?
    name.value unless name.nil?
  end

  def self.instance_to_hash(instance)
    attachments = instance.respond_to?(:attachments) ? (instance.attachments.respond_to?(:to_hash) ? instance.attachments.to_hash : instance.attachments) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    internet_gateway_id = instance.respond_to?(:internet_gateway_id) ? (instance.internet_gateway_id.respond_to?(:to_hash) ? instance.internet_gateway_id.to_hash : instance.internet_gateway_id) : nil
    internet_gateway_ids = instance.respond_to?(:internet_gateway_ids) ? (instance.internet_gateway_ids.respond_to?(:to_hash) ? instance.internet_gateway_ids.to_hash : instance.internet_gateway_ids) : nil
    owner_id = instance.respond_to?(:owner_id) ? (instance.owner_id.respond_to?(:to_hash) ? instance.owner_id.to_hash : instance.owner_id) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:attachments] = attachments unless attachments.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:internet_gateway_id] = internet_gateway_id unless internet_gateway_id.nil?
    hash[:internet_gateway_ids] = internet_gateway_ids unless internet_gateway_ids.nil?
    hash[:owner_id] = owner_id unless owner_id.nil?
    hash[:tags] = tags unless tags.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EC2::Client.new(region: self.class.region)
    response = client.create_internet_gateway(build_hash)
    res = response.respond_to?(:internet_gateway) ? response.internet_gateway : response
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
    internet_gateway = {}
    if @is_create || @is_update
      internet_gateway[:dry_run] = resource[:dry_run] unless resource[:dry_run].nil?
      internet_gateway[:filters] = resource[:filters] unless resource[:filters].nil?
      internet_gateway[:internet_gateway_id] = resource[:internet_gateway_id] unless resource[:internet_gateway_id].nil?
      internet_gateway[:internet_gateway_ids] = resource[:internet_gateway_ids] unless resource[:internet_gateway_ids].nil?
    end
    symbolize(internet_gateway)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_internet_gateway')
    client = Aws::EC2::Client.new(region: self.class.region)
    client.delete_internet_gateway(namevar => resource.provider.property_hash[namevar])
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
