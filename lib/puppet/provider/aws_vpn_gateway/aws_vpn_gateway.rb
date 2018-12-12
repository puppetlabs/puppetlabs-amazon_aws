require 'json'
require 'retries'

require 'aws-sdk-ec2'


Puppet::Type.type(:aws_vpn_gateway).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end

  def namevar
    :vpn_gateway_id
  end

  # Properties

  def amazon_side_asn=(value)
    Puppet.info("amazon_side_asn setter called to change to #{value}")
    @property_flush[:amazon_side_asn] = value
  end

  def availability_zone=(value)
    Puppet.info("availability_zone setter called to change to #{value}")
    @property_flush[:availability_zone] = value
  end

  def dry_run=(value)
    Puppet.info("dry_run setter called to change to #{value}")
    @property_flush[:dry_run] = value
  end

  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end

  def state=(value)
    Puppet.info("state setter called to change to #{value}")
    @property_flush[:state] = value
  end

  def tags=(value)
    Puppet.info("tags setter called to change to #{value}")
    @property_flush[:tags] = value
  end

  def type=(value)
    Puppet.info("type setter called to change to #{value}")
    @property_flush[:type] = value
  end

  def vpc_attachments=(value)
    Puppet.info("vpc_attachments setter called to change to #{value}")
    @property_flush[:vpc_attachments] = value
  end

  def vpn_gateway_id=(value)
    Puppet.info("vpn_gateway_id setter called to change to #{value}")
    @property_flush[:vpn_gateway_id] = value
  end

  def vpn_gateway_ids=(value)
    Puppet.info("vpn_gateway_ids setter called to change to #{value}")
    @property_flush[:vpn_gateway_ids] = value
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
    client.describe_vpn_gateways.each do |response|
      response.vpn_gateways.each do |i|
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
    amazon_side_asn = instance.respond_to?(:amazon_side_asn) ? (instance.amazon_side_asn.respond_to?(:to_hash) ? instance.amazon_side_asn.to_hash : instance.amazon_side_asn) : nil
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    state = instance.respond_to?(:state) ? (instance.state.respond_to?(:to_hash) ? instance.state.to_hash : instance.state) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    type = instance.respond_to?(:type) ? (instance.type.respond_to?(:to_hash) ? instance.type.to_hash : instance.type) : nil
    vpc_attachments = instance.respond_to?(:vpc_attachments) ? (instance.vpc_attachments.respond_to?(:to_hash) ? instance.vpc_attachments.to_hash : instance.vpc_attachments) : nil
    vpn_gateway_id = instance.respond_to?(:vpn_gateway_id) ? (instance.vpn_gateway_id.respond_to?(:to_hash) ? instance.vpn_gateway_id.to_hash : instance.vpn_gateway_id) : nil
    vpn_gateway_ids = instance.respond_to?(:vpn_gateway_ids) ? (instance.vpn_gateway_ids.respond_to?(:to_hash) ? instance.vpn_gateway_ids.to_hash : instance.vpn_gateway_ids) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:amazon_side_asn] = amazon_side_asn unless amazon_side_asn.nil?
    hash[:availability_zone] = availability_zone unless availability_zone.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:state] = state unless state.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:type] = type unless type.nil?
    hash[:vpc_attachments] = vpc_attachments unless vpc_attachments.nil?
    hash[:vpn_gateway_id] = vpn_gateway_id unless vpn_gateway_id.nil?
    hash[:vpn_gateway_ids] = vpn_gateway_ids unless vpn_gateway_ids.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EC2::Client.new(region: self.class.region)
    response = client.create_vpn_gateway(build_hash)
    res = response.respond_to?(:vpn_gateway) ? response.vpn_gateway : response
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
    vpn_gateway = {}
    if @is_create || @is_update
      vpn_gateway[:amazon_side_asn] = resource[:amazon_side_asn] unless resource[:amazon_side_asn].nil?
      vpn_gateway[:availability_zone] = resource[:availability_zone] unless resource[:availability_zone].nil?
      vpn_gateway[:dry_run] = resource[:dry_run] unless resource[:dry_run].nil?
      vpn_gateway[:filters] = resource[:filters] unless resource[:filters].nil?
      vpn_gateway[:type] = resource[:type] unless resource[:type].nil?
      vpn_gateway[:vpn_gateway_id] = resource[:vpn_gateway_id] unless resource[:vpn_gateway_id].nil?
      vpn_gateway[:vpn_gateway_ids] = resource[:vpn_gateway_ids] unless resource[:vpn_gateway_ids].nil?
    end
    symbolize(vpn_gateway)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_vpn_gateway')
    client = Aws::EC2::Client.new(region: self.class.region)
    client.delete_vpn_gateway(namevar => resource.provider.property_hash[namevar])
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
