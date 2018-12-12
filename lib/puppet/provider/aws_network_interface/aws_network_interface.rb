require 'json'
require 'retries'

require 'aws-sdk-ec2'


Puppet::Type.type(:aws_network_interface).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end

  def namevar
    :network_interface_id
  end

  # Properties

  def association=(value)
    Puppet.info("association setter called to change to #{value}")
    @property_flush[:association] = value
  end

  def attachment=(value)
    Puppet.info("attachment setter called to change to #{value}")
    @property_flush[:attachment] = value
  end

  def availability_zone=(value)
    Puppet.info("availability_zone setter called to change to #{value}")
    @property_flush[:availability_zone] = value
  end

  def description=(value)
    Puppet.info("description setter called to change to #{value}")
    @property_flush[:description] = value
  end

  def dry_run=(value)
    Puppet.info("dry_run setter called to change to #{value}")
    @property_flush[:dry_run] = value
  end

  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end

  def groups=(value)
    Puppet.info("groups setter called to change to #{value}")
    @property_flush[:groups] = value
  end

  def interface_type=(value)
    Puppet.info("interface_type setter called to change to #{value}")
    @property_flush[:interface_type] = value
  end

  def ipv6_address_count=(value)
    Puppet.info("ipv6_address_count setter called to change to #{value}")
    @property_flush[:ipv6_address_count] = value
  end

  def ipv6_addresses=(value)
    Puppet.info("ipv6_addresses setter called to change to #{value}")
    @property_flush[:ipv6_addresses] = value
  end

  def mac_address=(value)
    Puppet.info("mac_address setter called to change to #{value}")
    @property_flush[:mac_address] = value
  end

  def max_results=(value)
    Puppet.info("max_results setter called to change to #{value}")
    @property_flush[:max_results] = value
  end

  def network_interface_id=(value)
    Puppet.info("network_interface_id setter called to change to #{value}")
    @property_flush[:network_interface_id] = value
  end

  def network_interface_ids=(value)
    Puppet.info("network_interface_ids setter called to change to #{value}")
    @property_flush[:network_interface_ids] = value
  end

  def next_token=(value)
    Puppet.info("next_token setter called to change to #{value}")
    @property_flush[:next_token] = value
  end

  def owner_id=(value)
    Puppet.info("owner_id setter called to change to #{value}")
    @property_flush[:owner_id] = value
  end

  def private_dns_name=(value)
    Puppet.info("private_dns_name setter called to change to #{value}")
    @property_flush[:private_dns_name] = value
  end

  def private_ip_address=(value)
    Puppet.info("private_ip_address setter called to change to #{value}")
    @property_flush[:private_ip_address] = value
  end

  def private_ip_addresses=(value)
    Puppet.info("private_ip_addresses setter called to change to #{value}")
    @property_flush[:private_ip_addresses] = value
  end

  def requester_id=(value)
    Puppet.info("requester_id setter called to change to #{value}")
    @property_flush[:requester_id] = value
  end

  def requester_managed=(value)
    Puppet.info("requester_managed setter called to change to #{value}")
    @property_flush[:requester_managed] = value
  end

  def secondary_private_ip_address_count=(value)
    Puppet.info("secondary_private_ip_address_count setter called to change to #{value}")
    @property_flush[:secondary_private_ip_address_count] = value
  end

  def source_dest_check=(value)
    Puppet.info("source_dest_check setter called to change to #{value}")
    @property_flush[:source_dest_check] = value
  end

  def status=(value)
    Puppet.info("status setter called to change to #{value}")
    @property_flush[:status] = value
  end

  def subnet_id=(value)
    Puppet.info("subnet_id setter called to change to #{value}")
    @property_flush[:subnet_id] = value
  end

  def tag_set=(value)
    Puppet.info("tag_set setter called to change to #{value}")
    @property_flush[:tag_set] = value
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
    client.describe_network_interfaces.each do |response|
      response.network_interfaces.each do |i|
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
    association = instance.respond_to?(:association) ? (instance.association.respond_to?(:to_hash) ? instance.association.to_hash : instance.association) : nil
    attachment = instance.respond_to?(:attachment) ? (instance.attachment.respond_to?(:to_hash) ? instance.attachment.to_hash : instance.attachment) : nil
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone) : nil
    description = instance.respond_to?(:description) ? (instance.description.respond_to?(:to_hash) ? instance.description.to_hash : instance.description) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    groups = instance.respond_to?(:groups) ? (instance.groups.respond_to?(:to_hash) ? instance.groups.to_hash : instance.groups) : nil
    interface_type = instance.respond_to?(:interface_type) ? (instance.interface_type.respond_to?(:to_hash) ? instance.interface_type.to_hash : instance.interface_type) : nil
    ipv6_address_count = instance.respond_to?(:ipv6_address_count) ? (instance.ipv6_address_count.respond_to?(:to_hash) ? instance.ipv6_address_count.to_hash : instance.ipv6_address_count) : nil
    ipv6_addresses = instance.respond_to?(:ipv6_addresses) ? (instance.ipv6_addresses.respond_to?(:to_hash) ? instance.ipv6_addresses.to_hash : instance.ipv6_addresses) : nil
    mac_address = instance.respond_to?(:mac_address) ? (instance.mac_address.respond_to?(:to_hash) ? instance.mac_address.to_hash : instance.mac_address) : nil
    max_results = instance.respond_to?(:max_results) ? (instance.max_results.respond_to?(:to_hash) ? instance.max_results.to_hash : instance.max_results) : nil
    network_interface_id = instance.respond_to?(:network_interface_id) ? (instance.network_interface_id.respond_to?(:to_hash) ? instance.network_interface_id.to_hash : instance.network_interface_id) : nil
    network_interface_ids = instance.respond_to?(:network_interface_ids) ? (instance.network_interface_ids.respond_to?(:to_hash) ? instance.network_interface_ids.to_hash : instance.network_interface_ids) : nil
    next_token = instance.respond_to?(:next_token) ? (instance.next_token.respond_to?(:to_hash) ? instance.next_token.to_hash : instance.next_token) : nil
    owner_id = instance.respond_to?(:owner_id) ? (instance.owner_id.respond_to?(:to_hash) ? instance.owner_id.to_hash : instance.owner_id) : nil
    private_dns_name = instance.respond_to?(:private_dns_name) ? (instance.private_dns_name.respond_to?(:to_hash) ? instance.private_dns_name.to_hash : instance.private_dns_name) : nil
    private_ip_address = instance.respond_to?(:private_ip_address) ? (instance.private_ip_address.respond_to?(:to_hash) ? instance.private_ip_address.to_hash : instance.private_ip_address) : nil
    private_ip_addresses = instance.respond_to?(:private_ip_addresses) ? (instance.private_ip_addresses.respond_to?(:to_hash) ? instance.private_ip_addresses.to_hash : instance.private_ip_addresses) : nil
    requester_id = instance.respond_to?(:requester_id) ? (instance.requester_id.respond_to?(:to_hash) ? instance.requester_id.to_hash : instance.requester_id) : nil
    requester_managed = instance.respond_to?(:requester_managed) ? (instance.requester_managed.respond_to?(:to_hash) ? instance.requester_managed.to_hash : instance.requester_managed) : nil
    secondary_private_ip_address_count = instance.respond_to?(:secondary_private_ip_address_count) ? (instance.secondary_private_ip_address_count.respond_to?(:to_hash) ? instance.secondary_private_ip_address_count.to_hash : instance.secondary_private_ip_address_count) : nil
    source_dest_check = instance.respond_to?(:source_dest_check) ? (instance.source_dest_check.respond_to?(:to_hash) ? instance.source_dest_check.to_hash : instance.source_dest_check) : nil
    status = instance.respond_to?(:status) ? (instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status) : nil
    subnet_id = instance.respond_to?(:subnet_id) ? (instance.subnet_id.respond_to?(:to_hash) ? instance.subnet_id.to_hash : instance.subnet_id) : nil
    tag_set = instance.respond_to?(:tag_set) ? (instance.tag_set.respond_to?(:to_hash) ? instance.tag_set.to_hash : instance.tag_set) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:association] = association unless association.nil?
    hash[:attachment] = attachment unless attachment.nil?
    hash[:availability_zone] = availability_zone unless availability_zone.nil?
    hash[:description] = description unless description.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:groups] = groups unless groups.nil?
    hash[:interface_type] = interface_type unless interface_type.nil?
    hash[:ipv6_address_count] = ipv6_address_count unless ipv6_address_count.nil?
    hash[:ipv6_addresses] = ipv6_addresses unless ipv6_addresses.nil?
    hash[:mac_address] = mac_address unless mac_address.nil?
    hash[:max_results] = max_results unless max_results.nil?
    hash[:network_interface_id] = network_interface_id unless network_interface_id.nil?
    hash[:network_interface_ids] = network_interface_ids unless network_interface_ids.nil?
    hash[:next_token] = next_token unless next_token.nil?
    hash[:owner_id] = owner_id unless owner_id.nil?
    hash[:private_dns_name] = private_dns_name unless private_dns_name.nil?
    hash[:private_ip_address] = private_ip_address unless private_ip_address.nil?
    hash[:private_ip_addresses] = private_ip_addresses unless private_ip_addresses.nil?
    hash[:requester_id] = requester_id unless requester_id.nil?
    hash[:requester_managed] = requester_managed unless requester_managed.nil?
    hash[:secondary_private_ip_address_count] = secondary_private_ip_address_count unless secondary_private_ip_address_count.nil?
    hash[:source_dest_check] = source_dest_check unless source_dest_check.nil?
    hash[:status] = status unless status.nil?
    hash[:subnet_id] = subnet_id unless subnet_id.nil?
    hash[:tag_set] = tag_set unless tag_set.nil?
    hash[:vpc_id] = vpc_id unless vpc_id.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EC2::Client.new(region: self.class.region)
    response = client.create_network_interface(build_hash)
    res = response.respond_to?(:network_interface) ? response.network_interface : response
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
    network_interface = {}
    if @is_create || @is_update
      network_interface[:description] = resource[:description] unless resource[:description].nil?
      network_interface[:dry_run] = resource[:dry_run] unless resource[:dry_run].nil?
      network_interface[:filters] = resource[:filters] unless resource[:filters].nil?
      network_interface[:groups] = resource[:groups] unless resource[:groups].nil?
      network_interface[:ipv6_address_count] = resource[:ipv6_address_count] unless resource[:ipv6_address_count].nil?
      network_interface[:ipv6_addresses] = resource[:ipv6_addresses] unless resource[:ipv6_addresses].nil?
      network_interface[:max_results] = resource[:max_results] unless resource[:max_results].nil?
      network_interface[:network_interface_id] = resource[:network_interface_id] unless resource[:network_interface_id].nil?
      network_interface[:network_interface_ids] = resource[:network_interface_ids] unless resource[:network_interface_ids].nil?
      network_interface[:next_token] = resource[:next_token] unless resource[:next_token].nil?
      network_interface[:private_ip_address] = resource[:private_ip_address] unless resource[:private_ip_address].nil?
      network_interface[:private_ip_addresses] = resource[:private_ip_addresses] unless resource[:private_ip_addresses].nil?
      network_interface[:secondary_private_ip_address_count] = resource[:secondary_private_ip_address_count] unless resource[:secondary_private_ip_address_count].nil?
      network_interface[:subnet_id] = resource[:subnet_id] unless resource[:subnet_id].nil?
    end
    symbolize(network_interface)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_network_interface')
    client = Aws::EC2::Client.new(region: self.class.region)
    client.delete_network_interface(namevar => resource.provider.property_hash[namevar])
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
