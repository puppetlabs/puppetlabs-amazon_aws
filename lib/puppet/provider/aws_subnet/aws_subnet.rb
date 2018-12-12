require 'json'
require 'retries'

require 'aws-sdk-ec2'


Puppet::Type.type(:aws_subnet).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end

  def namevar
    :subnet_id
  end

  # Properties

  def assign_ipv6_address_on_creation=(value)
    Puppet.info("assign_ipv6_address_on_creation setter called to change to #{value}")
    @property_flush[:assign_ipv6_address_on_creation] = value
  end

  def availability_zone=(value)
    Puppet.info("availability_zone setter called to change to #{value}")
    @property_flush[:availability_zone] = value
  end

  def availability_zone_id=(value)
    Puppet.info("availability_zone_id setter called to change to #{value}")
    @property_flush[:availability_zone_id] = value
  end

  def available_ip_address_count=(value)
    Puppet.info("available_ip_address_count setter called to change to #{value}")
    @property_flush[:available_ip_address_count] = value
  end

  def cidr_block=(value)
    Puppet.info("cidr_block setter called to change to #{value}")
    @property_flush[:cidr_block] = value
  end

  def default_for_az=(value)
    Puppet.info("default_for_az setter called to change to #{value}")
    @property_flush[:default_for_az] = value
  end

  def dry_run=(value)
    Puppet.info("dry_run setter called to change to #{value}")
    @property_flush[:dry_run] = value
  end

  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end

  def ipv6_cidr_block=(value)
    Puppet.info("ipv6_cidr_block setter called to change to #{value}")
    @property_flush[:ipv6_cidr_block] = value
  end

  def ipv6_cidr_block_association_set=(value)
    Puppet.info("ipv6_cidr_block_association_set setter called to change to #{value}")
    @property_flush[:ipv6_cidr_block_association_set] = value
  end

  def map_public_ip_on_launch=(value)
    Puppet.info("map_public_ip_on_launch setter called to change to #{value}")
    @property_flush[:map_public_ip_on_launch] = value
  end

  def owner_id=(value)
    Puppet.info("owner_id setter called to change to #{value}")
    @property_flush[:owner_id] = value
  end

  def state=(value)
    Puppet.info("state setter called to change to #{value}")
    @property_flush[:state] = value
  end

  def subnet_arn=(value)
    Puppet.info("subnet_arn setter called to change to #{value}")
    @property_flush[:subnet_arn] = value
  end

  def subnet_id=(value)
    Puppet.info("subnet_id setter called to change to #{value}")
    @property_flush[:subnet_id] = value
  end

  def subnet_ids=(value)
    Puppet.info("subnet_ids setter called to change to #{value}")
    @property_flush[:subnet_ids] = value
  end

  def tags=(value)
    Puppet.info("tags setter called to change to #{value}")
    @property_flush[:tags] = value
  end

  def vpc_id=(value)
    Puppet.info("vpc_id setter called to change to #{value}")
    @property_flush[:vpc_id] = value
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
    client.describe_subnets.each do |response|
      response.subnets.each do |i|
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
    assign_ipv6_address_on_creation = instance.respond_to?(:assign_ipv6_address_on_creation) ? (instance.assign_ipv6_address_on_creation.respond_to?(:to_hash) ? instance.assign_ipv6_address_on_creation.to_hash : instance.assign_ipv6_address_on_creation) : nil
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone) : nil
    availability_zone_id = instance.respond_to?(:availability_zone_id) ? (instance.availability_zone_id.respond_to?(:to_hash) ? instance.availability_zone_id.to_hash : instance.availability_zone_id) : nil
    available_ip_address_count = instance.respond_to?(:available_ip_address_count) ? (instance.available_ip_address_count.respond_to?(:to_hash) ? instance.available_ip_address_count.to_hash : instance.available_ip_address_count) : nil
    cidr_block = instance.respond_to?(:cidr_block) ? (instance.cidr_block.respond_to?(:to_hash) ? instance.cidr_block.to_hash : instance.cidr_block) : nil
    default_for_az = instance.respond_to?(:default_for_az) ? (instance.default_for_az.respond_to?(:to_hash) ? instance.default_for_az.to_hash : instance.default_for_az) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    ipv6_cidr_block = instance.respond_to?(:ipv6_cidr_block) ? (instance.ipv6_cidr_block.respond_to?(:to_hash) ? instance.ipv6_cidr_block.to_hash : instance.ipv6_cidr_block) : nil
    ipv6_cidr_block_association_set = instance.respond_to?(:ipv6_cidr_block_association_set) ? (instance.ipv6_cidr_block_association_set.respond_to?(:to_hash) ? instance.ipv6_cidr_block_association_set.to_hash : instance.ipv6_cidr_block_association_set) : nil
    map_public_ip_on_launch = instance.respond_to?(:map_public_ip_on_launch) ? (instance.map_public_ip_on_launch.respond_to?(:to_hash) ? instance.map_public_ip_on_launch.to_hash : instance.map_public_ip_on_launch) : nil
    owner_id = instance.respond_to?(:owner_id) ? (instance.owner_id.respond_to?(:to_hash) ? instance.owner_id.to_hash : instance.owner_id) : nil
    state = instance.respond_to?(:state) ? (instance.state.respond_to?(:to_hash) ? instance.state.to_hash : instance.state) : nil
    subnet_arn = instance.respond_to?(:subnet_arn) ? (instance.subnet_arn.respond_to?(:to_hash) ? instance.subnet_arn.to_hash : instance.subnet_arn) : nil
    subnet_id = instance.respond_to?(:subnet_id) ? (instance.subnet_id.respond_to?(:to_hash) ? instance.subnet_id.to_hash : instance.subnet_id) : nil
    subnet_ids = instance.respond_to?(:subnet_ids) ? (instance.subnet_ids.respond_to?(:to_hash) ? instance.subnet_ids.to_hash : instance.subnet_ids) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:assign_ipv6_address_on_creation] = assign_ipv6_address_on_creation unless assign_ipv6_address_on_creation.nil?
    hash[:availability_zone] = availability_zone unless availability_zone.nil?
    hash[:availability_zone_id] = availability_zone_id unless availability_zone_id.nil?
    hash[:available_ip_address_count] = available_ip_address_count unless available_ip_address_count.nil?
    hash[:cidr_block] = cidr_block unless cidr_block.nil?
    hash[:default_for_az] = default_for_az unless default_for_az.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:ipv6_cidr_block] = ipv6_cidr_block unless ipv6_cidr_block.nil?
    hash[:ipv6_cidr_block_association_set] = ipv6_cidr_block_association_set unless ipv6_cidr_block_association_set.nil?
    hash[:map_public_ip_on_launch] = map_public_ip_on_launch unless map_public_ip_on_launch.nil?
    hash[:owner_id] = owner_id unless owner_id.nil?
    hash[:state] = state unless state.nil?
    hash[:subnet_arn] = subnet_arn unless subnet_arn.nil?
    hash[:subnet_id] = subnet_id unless subnet_id.nil?
    hash[:subnet_ids] = subnet_ids unless subnet_ids.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:vpc_id] = vpc_id unless vpc_id.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EC2::Client.new(region: self.class.region)
    response = client.create_subnet(build_hash)
    res = response.respond_to?(:subnet) ? response.subnet : response
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
    subnet = {}
    if @is_create || @is_update
      subnet[:availability_zone] = resource[:availability_zone] unless resource[:availability_zone].nil?
      subnet[:availability_zone_id] = resource[:availability_zone_id] unless resource[:availability_zone_id].nil?
      subnet[:cidr_block] = resource[:cidr_block] unless resource[:cidr_block].nil?
      subnet[:dry_run] = resource[:dry_run] unless resource[:dry_run].nil?
      subnet[:filters] = resource[:filters] unless resource[:filters].nil?
      subnet[:ipv6_cidr_block] = resource[:ipv6_cidr_block] unless resource[:ipv6_cidr_block].nil?
      subnet[:subnet_id] = resource[:subnet_id] unless resource[:subnet_id].nil?
      subnet[:subnet_ids] = resource[:subnet_ids] unless resource[:subnet_ids].nil?
      subnet[:vpc_id] = resource[:vpc_id] unless resource[:vpc_id].nil?
    end
    symbolize(subnet)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_subnet')
    client = Aws::EC2::Client.new(region: self.class.region)
    client.delete_subnet(namevar => resource.provider.property_hash[namevar])
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
