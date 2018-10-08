require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-ec2"


Puppet::Type.type(:aws_instances).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  
  # instance only EC2 support 
  def namevar
    :instance_ids
    
  end

  def self.namevar
    :instance_ids
    
  end
  
  # Properties

  def additional_info=(value)
    Puppet.info("additional_info setter called to change to #{value}")
    @property_flush[:additional_info] = value
  end
  

  def block_device_mappings=(value)
    Puppet.info("block_device_mappings setter called to change to #{value}")
    @property_flush[:block_device_mappings] = value
  end
  

  def client_token=(value)
    Puppet.info("client_token setter called to change to #{value}")
    @property_flush[:client_token] = value
  end
  

  def cpu_options=(value)
    Puppet.info("cpu_options setter called to change to #{value}")
    @property_flush[:cpu_options] = value
  end
  

  def credit_specification=(value)
    Puppet.info("credit_specification setter called to change to #{value}")
    @property_flush[:credit_specification] = value
  end
  

  def disable_api_termination=(value)
    Puppet.info("disable_api_termination setter called to change to #{value}")
    @property_flush[:disable_api_termination] = value
  end
  

  def dry_run=(value)
    Puppet.info("dry_run setter called to change to #{value}")
    @property_flush[:dry_run] = value
  end
  

  def ebs_optimized=(value)
    Puppet.info("ebs_optimized setter called to change to #{value}")
    @property_flush[:ebs_optimized] = value
  end
  

  def elastic_gpu_specification=(value)
    Puppet.info("elastic_gpu_specification setter called to change to #{value}")
    @property_flush[:elastic_gpu_specification] = value
  end
  

  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end
  

  def iam_instance_profile=(value)
    Puppet.info("iam_instance_profile setter called to change to #{value}")
    @property_flush[:iam_instance_profile] = value
  end
  

  def image_id=(value)
    Puppet.info("image_id setter called to change to #{value}")
    @property_flush[:image_id] = value
  end
  

  def instance_ids=(value)
    Puppet.info("instance_ids setter called to change to #{value}")
    @property_flush[:instance_ids] = value
  end
  

  def instance_initiated_shutdown_behavior=(value)
    Puppet.info("instance_initiated_shutdown_behavior setter called to change to #{value}")
    @property_flush[:instance_initiated_shutdown_behavior] = value
  end
  

  def instance_market_options=(value)
    Puppet.info("instance_market_options setter called to change to #{value}")
    @property_flush[:instance_market_options] = value
  end
  

  def instance_type=(value)
    Puppet.info("instance_type setter called to change to #{value}")
    @property_flush[:instance_type] = value
  end
  

  def ipv6_address_count=(value)
    Puppet.info("ipv6_address_count setter called to change to #{value}")
    @property_flush[:ipv6_address_count] = value
  end
  

  def ipv6_addresses=(value)
    Puppet.info("ipv6_addresses setter called to change to #{value}")
    @property_flush[:ipv6_addresses] = value
  end
  

  def kernel_id=(value)
    Puppet.info("kernel_id setter called to change to #{value}")
    @property_flush[:kernel_id] = value
  end
  

  def key_name=(value)
    Puppet.info("key_name setter called to change to #{value}")
    @property_flush[:key_name] = value
  end
  

  def launch_template=(value)
    Puppet.info("launch_template setter called to change to #{value}")
    @property_flush[:launch_template] = value
  end
  

  def max_count=(value)
    Puppet.info("max_count setter called to change to #{value}")
    @property_flush[:max_count] = value
  end
  

  def max_results=(value)
    Puppet.info("max_results setter called to change to #{value}")
    @property_flush[:max_results] = value
  end
  

  def min_count=(value)
    Puppet.info("min_count setter called to change to #{value}")
    @property_flush[:min_count] = value
  end
  

  def monitoring=(value)
    Puppet.info("monitoring setter called to change to #{value}")
    @property_flush[:monitoring] = value
  end
  

  def network_interfaces=(value)
    Puppet.info("network_interfaces setter called to change to #{value}")
    @property_flush[:network_interfaces] = value
  end
  

  def next_token=(value)
    Puppet.info("next_token setter called to change to #{value}")
    @property_flush[:next_token] = value
  end
  

  def placement=(value)
    Puppet.info("placement setter called to change to #{value}")
    @property_flush[:placement] = value
  end
  

  def private_ip_address=(value)
    Puppet.info("private_ip_address setter called to change to #{value}")
    @property_flush[:private_ip_address] = value
  end
  

  def ramdisk_id=(value)
    Puppet.info("ramdisk_id setter called to change to #{value}")
    @property_flush[:ramdisk_id] = value
  end
  

  def security_group_ids=(value)
    Puppet.info("security_group_ids setter called to change to #{value}")
    @property_flush[:security_group_ids] = value
  end
  

  def security_groups=(value)
    Puppet.info("security_groups setter called to change to #{value}")
    @property_flush[:security_groups] = value
  end
  

  def subnet_id=(value)
    Puppet.info("subnet_id setter called to change to #{value}")
    @property_flush[:subnet_id] = value
  end
  

  def tag_specifications=(value)
    Puppet.info("tag_specifications setter called to change to #{value}")
    @property_flush[:tag_specifications] = value
  end
  

  def user_data=(value)
    Puppet.info("user_data setter called to change to #{value}")
    @property_flush[:user_data] = value
  end
  
def name=(value)
    Puppet.info("name setter called to change to #{value}")
    @property_flush[:name] = value
  end

  def property_hash
    @property_hash
  end

  def self.get_region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def self.exists
      yield
      rescue NoMethodError
        return false
  end

  def self.has_name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end
  def self.instances
    Puppet.debug("Calling instances for region #{self.get_region}")
    client = Aws::EC2::Client.new(region: self.get_region)

    all_instances = []
    client.describe_instances(filters: [
          {name: 'instance-state-name', values: ['pending', 'running', 'stopping', 'stopped']}
        ]).each do |response|
      response.reservations.each do |r|
        r.instances.each do |i|
          hash = instance_to_hash(i)
          all_instances << new(hash) if has_name?(hash)
	      end
      end
    end
    all_instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      tags = prov.respond_to?(:tags) ? prov.tags : nil
      if tags 
        name = tags.find { |x| x[:key] == "Name" }[:value]
        if (resource = (resources.find { |k, v| k.casecmp(name).zero? } || [])[1])
          resource.provider = prov
        end
      end
    end
  end

  def self.name_from_tag(instance)
    tags = instance.respond_to?(:tags) ? instance.tags : nil
    name = tags.find { |x| x.key == 'Name' } unless tags.nil?
    name.value unless name.nil?
  end

  def self.instance_to_hash(instance)

    additional_info = instance.respond_to?(:additional_info) ? (instance.additional_info.respond_to?(:to_hash) ? instance.additional_info.to_hash : instance.additional_info ) : nil
    block_device_mappings = instance.respond_to?(:block_device_mappings) ? (instance.block_device_mappings.respond_to?(:to_hash) ? instance.block_device_mappings.to_hash : instance.block_device_mappings ) : nil
    client_token = instance.respond_to?(:client_token) ? (instance.client_token.respond_to?(:to_hash) ? instance.client_token.to_hash : instance.client_token ) : nil
    cpu_options = instance.respond_to?(:cpu_options) ? (instance.cpu_options.respond_to?(:to_hash) ? instance.cpu_options.to_hash : instance.cpu_options ) : nil
    credit_specification = instance.respond_to?(:credit_specification) ? (instance.credit_specification.respond_to?(:to_hash) ? instance.credit_specification.to_hash : instance.credit_specification ) : nil
    disable_api_termination = instance.respond_to?(:disable_api_termination) ? (instance.disable_api_termination.respond_to?(:to_hash) ? instance.disable_api_termination.to_hash : instance.disable_api_termination ) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run ) : nil
    ebs_optimized = instance.respond_to?(:ebs_optimized) ? (instance.ebs_optimized.respond_to?(:to_hash) ? instance.ebs_optimized.to_hash : instance.ebs_optimized ) : nil
    elastic_gpu_specification = instance.respond_to?(:elastic_gpu_specification) ? (instance.elastic_gpu_specification.respond_to?(:to_hash) ? instance.elastic_gpu_specification.to_hash : instance.elastic_gpu_specification ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    iam_instance_profile = instance.respond_to?(:iam_instance_profile) ? (instance.iam_instance_profile.respond_to?(:to_hash) ? instance.iam_instance_profile.to_hash : instance.iam_instance_profile ) : nil
    image_id = instance.respond_to?(:image_id) ? (instance.image_id.respond_to?(:to_hash) ? instance.image_id.to_hash : instance.image_id ) : nil
    instance_ids = instance.respond_to?(:instance_ids) ? (instance.instance_ids.respond_to?(:to_hash) ? instance.instance_ids.to_hash : instance.instance_ids ) : nil
    instance_initiated_shutdown_behavior = instance.respond_to?(:instance_initiated_shutdown_behavior) ? (instance.instance_initiated_shutdown_behavior.respond_to?(:to_hash) ? instance.instance_initiated_shutdown_behavior.to_hash : instance.instance_initiated_shutdown_behavior ) : nil
    instance_market_options = instance.respond_to?(:instance_market_options) ? (instance.instance_market_options.respond_to?(:to_hash) ? instance.instance_market_options.to_hash : instance.instance_market_options ) : nil
    instance_type = instance.respond_to?(:instance_type) ? (instance.instance_type.respond_to?(:to_hash) ? instance.instance_type.to_hash : instance.instance_type ) : nil
    ipv6_address_count = instance.respond_to?(:ipv6_address_count) ? (instance.ipv6_address_count.respond_to?(:to_hash) ? instance.ipv6_address_count.to_hash : instance.ipv6_address_count ) : nil
    ipv6_addresses = instance.respond_to?(:ipv6_addresses) ? (instance.ipv6_addresses.respond_to?(:to_hash) ? instance.ipv6_addresses.to_hash : instance.ipv6_addresses ) : nil
    kernel_id = instance.respond_to?(:kernel_id) ? (instance.kernel_id.respond_to?(:to_hash) ? instance.kernel_id.to_hash : instance.kernel_id ) : nil
    key_name = instance.respond_to?(:key_name) ? (instance.key_name.respond_to?(:to_hash) ? instance.key_name.to_hash : instance.key_name ) : nil
    launch_template = instance.respond_to?(:launch_template) ? (instance.launch_template.respond_to?(:to_hash) ? instance.launch_template.to_hash : instance.launch_template ) : nil
    max_count = instance.respond_to?(:max_count) ? (instance.max_count.respond_to?(:to_hash) ? instance.max_count.to_hash : instance.max_count ) : nil
    max_results = instance.respond_to?(:max_results) ? (instance.max_results.respond_to?(:to_hash) ? instance.max_results.to_hash : instance.max_results ) : nil
    min_count = instance.respond_to?(:min_count) ? (instance.min_count.respond_to?(:to_hash) ? instance.min_count.to_hash : instance.min_count ) : nil
    monitoring = instance.respond_to?(:monitoring) ? (instance.monitoring.respond_to?(:to_hash) ? instance.monitoring.to_hash : instance.monitoring ) : nil
    network_interfaces = instance.respond_to?(:network_interfaces) ? (instance.network_interfaces.respond_to?(:to_hash) ? instance.network_interfaces.to_hash : instance.network_interfaces ) : nil
    next_token = instance.respond_to?(:next_token) ? (instance.next_token.respond_to?(:to_hash) ? instance.next_token.to_hash : instance.next_token ) : nil
    placement = instance.respond_to?(:placement) ? (instance.placement.respond_to?(:to_hash) ? instance.placement.to_hash : instance.placement ) : nil
    private_ip_address = instance.respond_to?(:private_ip_address) ? (instance.private_ip_address.respond_to?(:to_hash) ? instance.private_ip_address.to_hash : instance.private_ip_address ) : nil
    ramdisk_id = instance.respond_to?(:ramdisk_id) ? (instance.ramdisk_id.respond_to?(:to_hash) ? instance.ramdisk_id.to_hash : instance.ramdisk_id ) : nil
    security_group_ids = instance.respond_to?(:security_group_ids) ? (instance.security_group_ids.respond_to?(:to_hash) ? instance.security_group_ids.to_hash : instance.security_group_ids ) : nil
    security_groups = instance.respond_to?(:security_groups) ? (instance.security_groups.respond_to?(:to_hash) ? instance.security_groups.to_hash : instance.security_groups ) : nil
    subnet_id = instance.respond_to?(:subnet_id) ? (instance.subnet_id.respond_to?(:to_hash) ? instance.subnet_id.to_hash : instance.subnet_id ) : nil
    tag_specifications = instance.respond_to?(:tag_specifications) ? (instance.tag_specifications.respond_to?(:to_hash) ? instance.tag_specifications.to_hash : instance.tag_specifications ) : nil
    user_data = instance.respond_to?(:user_data) ? (instance.user_data.respond_to?(:to_hash) ? instance.user_data.to_hash : instance.user_data ) : nil
    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) and instance.tags.size > 0
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) and instance.tag_set.size > 0

    hash[:additional_info] = additional_info unless additional_info.nil?
    hash[:block_device_mappings] = block_device_mappings unless block_device_mappings.nil?
    hash[:client_token] = client_token unless client_token.nil?
    hash[:cpu_options] = cpu_options unless cpu_options.nil?
    hash[:credit_specification] = credit_specification unless credit_specification.nil?
    hash[:disable_api_termination] = disable_api_termination unless disable_api_termination.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:ebs_optimized] = ebs_optimized unless ebs_optimized.nil?
    hash[:elastic_gpu_specification] = elastic_gpu_specification unless elastic_gpu_specification.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:iam_instance_profile] = iam_instance_profile unless iam_instance_profile.nil?
    hash[:image_id] = image_id unless image_id.nil?
    hash[:instance_ids] = instance_ids unless instance_ids.nil?
    hash[:instance_initiated_shutdown_behavior] = instance_initiated_shutdown_behavior unless instance_initiated_shutdown_behavior.nil?
    hash[:instance_market_options] = instance_market_options unless instance_market_options.nil?
    hash[:instance_type] = instance_type unless instance_type.nil?
    hash[:ipv6_address_count] = ipv6_address_count unless ipv6_address_count.nil?
    hash[:ipv6_addresses] = ipv6_addresses unless ipv6_addresses.nil?
    hash[:kernel_id] = kernel_id unless kernel_id.nil?
    hash[:key_name] = key_name unless key_name.nil?
    hash[:launch_template] = launch_template unless launch_template.nil?
    hash[:max_count] = max_count unless max_count.nil?
    hash[:max_results] = max_results unless max_results.nil?
    hash[:min_count] = min_count unless min_count.nil?
    hash[:monitoring] = monitoring unless monitoring.nil?
    hash[:network_interfaces] = network_interfaces unless network_interfaces.nil?
    hash[:next_token] = next_token unless next_token.nil?
    hash[:placement] = placement unless placement.nil?
    hash[:private_ip_address] = private_ip_address unless private_ip_address.nil?
    hash[:ramdisk_id] = ramdisk_id unless ramdisk_id.nil?
    hash[:security_group_ids] = security_group_ids unless security_group_ids.nil?
    hash[:security_groups] = security_groups unless security_groups.nil?
    hash[:subnet_id] = subnet_id unless subnet_id.nil?
    hash[:tag_specifications] = tag_specifications unless tag_specifications.nil?
    hash[:user_data] = user_data unless user_data.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EC2::Client.new(region: self.class.get_region)
    response = client.run_instances(build_hash)
    ids = []
    response.instances.each do |r|
      ids.push(r.instance_id)
    end
    with_retries(:max_tries => 5) do
      client.create_tags(
        resources: ids,
        tags: [{ key: 'Name', value: resource[:name] },
                { key: 'lifetime', value: '1w'}]
      )
    end
    @property_hash[:ensure] = :present
  rescue Exception => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def flush
    Puppet.info("Entered flush for resource #{name} of type <no value> - creating ? #{@is_create}, deleting ? #{@is_delete}")
    if @is_create || @is_delete
      return # we've already done the create or delete
    end
    @is_update = true
    hash = build_hash
    Puppet.info("Calling Update on flush")
    @property_hash[:ensure] = :present
    response = []
  end

  def build_hash
    instances = {}
    if @is_create || @is_update
      instances[:additional_info] = resource[:additional_info] unless resource[:additional_info].nil?
      instances[:block_device_mappings] = resource[:block_device_mappings] unless resource[:block_device_mappings].nil?
      instances[:client_token] = resource[:client_token] unless resource[:client_token].nil?
      instances[:cpu_options] = resource[:cpu_options] unless resource[:cpu_options].nil?
      instances[:credit_specification] = resource[:credit_specification] unless resource[:credit_specification].nil?
      instances[:disable_api_termination] = resource[:disable_api_termination] unless resource[:disable_api_termination].nil?
      instances[:dry_run] = resource[:dry_run] unless resource[:dry_run].nil?
      instances[:ebs_optimized] = resource[:ebs_optimized] unless resource[:ebs_optimized].nil?
      instances[:elastic_gpu_specification] = resource[:elastic_gpu_specification] unless resource[:elastic_gpu_specification].nil?
      instances[:filters] = resource[:filters] unless resource[:filters].nil?
      instances[:iam_instance_profile] = resource[:iam_instance_profile] unless resource[:iam_instance_profile].nil?
      instances[:kernel_id] = resource[:kernel_id] unless resource[:kernel_id].nil?
      instances[:image_id] = resource[:image_id] unless resource[:image_id].nil?
      instances[:instance_ids] = resource[:instance_ids] unless resource[:instance_ids].nil?
      instances[:instance_initiated_shutdown_behavior] = resource[:instance_initiated_shutdown_behavior] unless resource[:instance_initiated_shutdown_behavior].nil?
      instances[:instance_market_options] = resource[:instance_market_options] unless resource[:instance_market_options].nil?
      instances[:instance_type] = resource[:instance_type] unless resource[:instance_type].nil?
      instances[:ipv6_address_count] = resource[:ipv6_address_count] unless resource[:ipv6_address_count].nil?
      instances[:ipv6_addresses] = resource[:ipv6_addresses] unless resource[:ipv6_addresses].nil?
      instances[:kernel_id] = resource[:kernel_id] unless resource[:kernel_id].nil?
      instances[:key_name] = resource[:key_name] unless resource[:key_name].nil?
      instances[:launch_template] = resource[:launch_template] unless resource[:launch_template].nil?
      instances[:max_count] = resource[:max_count] unless resource[:max_count].nil?
      instances[:max_results] = resource[:max_results] unless resource[:max_results].nil?
      instances[:min_count] = resource[:min_count] unless resource[:min_count].nil?
      instances[:monitoring] = resource[:monitoring] unless resource[:monitoring].nil?
      instances[:network_interfaces] = resource[:network_interfaces] unless resource[:network_interfaces].nil?
      instances[:next_token] = resource[:next_token] unless resource[:next_token].nil?
      instances[:placement] = resource[:placement] unless resource[:placement].nil?
      instances[:private_ip_address] = resource[:private_ip_address] unless resource[:private_ip_address].nil?
      instances[:ramdisk_id] = resource[:ramdisk_id] unless resource[:ramdisk_id].nil?
      instances[:security_group_ids] = resource[:security_group_ids] unless resource[:security_group_ids].nil?
      instances[:security_groups] = resource[:security_groups] unless resource[:security_groups].nil?
      instances[:subnet_id] = resource[:subnet_id] unless resource[:subnet_id].nil?
      instances[:tag_specifications] = resource[:tag_specifications] unless resource[:tag_specifications].nil?
      instances[:user_data] = resource[:user_data] unless resource[:user_data].nil?
    end
    return symbolize(instances)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info("Calling operation terminate_instances")
    client = Aws::EC2::Client.new(region: self.class.get_region)
    instance_id = resource.provider.property_hash[:object].instance_id
    client.terminate_instances(instance_ids: [instance_id])
    client.wait_until(:instance_terminated, instance_ids: [instance_id])
    @property_hash[:ensure] = :absent
  end


  # Shared funcs
  def exists?
    return_value = @property_hash[:ensure] && @property_hash[:ensure] != :absent
    Puppet.info("Checking if resource #{name} of type <no value> exists, returning #{return_value}")
    return_value
  end

  def property_hash
    @property_hash
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

# this is the end of the ruby class
