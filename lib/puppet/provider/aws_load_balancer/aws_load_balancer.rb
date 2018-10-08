require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-elasticloadbalancingv2"


Puppet::Type.type(:aws_load_balancer).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  # ELB properties
  def namevar
    :load_balancer_arn
  end

  # Properties

  def ip_address_type=(value)
    Puppet.info("ip_address_type setter called to change to #{value}")
    @property_flush[:ip_address_type] = value
  end

  def load_balancer_arn=(value)
    Puppet.info("load_balancer_arn setter called to change to #{value}")
    @property_flush[:load_balancer_arn] = value
  end

  def load_balancer_arns=(value)
    Puppet.info("load_balancer_arns setter called to change to #{value}")
    @property_flush[:load_balancer_arns] = value
  end

  def names=(value)
    Puppet.info("names setter called to change to #{value}")
    @property_flush[:names] = value
  end

  def page_size=(value)
    Puppet.info("page_size setter called to change to #{value}")
    @property_flush[:page_size] = value
  end

  def scheme=(value)
    Puppet.info("scheme setter called to change to #{value}")
    @property_flush[:scheme] = value
  end

  def security_groups=(value)
    Puppet.info("security_groups setter called to change to #{value}")
    @property_flush[:security_groups] = value
  end

  def subnet_mappings=(value)
    Puppet.info("subnet_mappings setter called to change to #{value}")
    @property_flush[:subnet_mappings] = value
  end

  def subnets=(value)
    Puppet.info("subnets setter called to change to #{value}")
    @property_flush[:subnets] = value
  end

  def tags=(value)
    Puppet.info("tags setter called to change to #{value}")
    @property_flush[:tags] = value
  end

  def type=(value)
    Puppet.info("type setter called to change to #{value}")
    @property_flush[:type] = value
  end


  def name=(value)
    Puppet.info("name setter called to change to #{value}")
    @property_flush[:name] = value
  end

  def self.get_region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def self.has_name?(hash)
    !hash[:load_balancer_name].nil? && !hash[:load_balancer_name].empty?
  end

  def self.instances
    Puppet.debug("Calling instances for region #{self.get_region}")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.get_region)

    all_instances = []
    client.describe_load_balancers.each do |response|
      response.load_balancers.each do |i|
        hash = instance_to_hash(i)
        all_instances << new(hash) if has_name?(hash)
      end
    end
    all_instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if (resource = (resources.find { |k, v| k.casecmp(prov.name).zero? } || [])[1])
        resource.provider = prov
      end
    end
  end

  def self.instance_to_hash(instance)

    ip_address_type = instance.respond_to?(:ip_address_type) ? (instance.ip_address_type.respond_to?(:to_hash) ? instance.ip_address_type.to_hash : instance.ip_address_type ) : nil
    load_balancer_arn = instance.respond_to?(:load_balancer_arn) ? (instance.load_balancer_arn.respond_to?(:to_hash) ? instance.load_balancer_arn.to_hash : instance.load_balancer_arn ) : nil
    load_balancer_arns = instance.respond_to?(:load_balancer_arns) ? (instance.load_balancer_arns.respond_to?(:to_hash) ? instance.load_balancer_arns.to_hash : instance.load_balancer_arns ) : nil
    names = instance.respond_to?(:names) ? (instance.names.respond_to?(:to_hash) ? instance.names.to_hash : instance.names ) : nil
    page_size = instance.respond_to?(:page_size) ? (instance.page_size.respond_to?(:to_hash) ? instance.page_size.to_hash : instance.page_size ) : nil
    scheme = instance.respond_to?(:scheme) ? (instance.scheme.respond_to?(:to_hash) ? instance.scheme.to_hash : instance.scheme ) : nil
    security_groups = instance.respond_to?(:security_groups) ? (instance.security_groups.respond_to?(:to_hash) ? instance.security_groups.to_hash : instance.security_groups ) : nil
    subnet_mappings = instance.respond_to?(:subnet_mappings) ? (instance.subnet_mappings.respond_to?(:to_hash) ? instance.subnet_mappings.to_hash : instance.subnet_mappings ) : nil
    subnets = instance.respond_to?(:subnets) ? (instance.subnets.respond_to?(:to_hash) ? instance.subnets.to_hash : instance.subnets ) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags ) : nil
    type = instance.respond_to?(:type) ? (instance.type.respond_to?(:to_hash) ? instance.type.to_hash : instance.type ) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = instance[:load_balancer_name]
    hash[:load_balancer_name] = instance[:load_balancer_name]


    hash[:ip_address_type] = ip_address_type unless ip_address_type.nil?
    hash[:load_balancer_arn] = load_balancer_arn unless load_balancer_arn.nil?
    hash[:load_balancer_arns] = load_balancer_arns unless load_balancer_arns.nil?
    hash[:names] = names unless names.nil?
    hash[:page_size] = page_size unless page_size.nil?
    hash[:scheme] = scheme unless scheme.nil?
    hash[:security_groups] = security_groups unless security_groups.nil?
    hash[:subnet_mappings] = subnet_mappings unless subnet_mappings.nil?
    hash[:subnets] = subnets unless subnets.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:type] = type unless type.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.get_region)
    client.create_load_balancer(build_hash)
    @property_hash[:ensure] = :present
  rescue Exception => ex
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
    hash = build_hash
    Puppet.info("Calling Update on flush")
    @property_hash[:ensure] = :present
    response = []
  end

  def build_hash
    load_balancer = {}
    if @is_create || @is_update
      load_balancer[:ip_address_type] = resource[:ip_address_type] unless resource[:ip_address_type].nil?
      load_balancer[:load_balancer_arn] = resource[:load_balancer_arn] unless resource[:load_balancer_arn].nil?
      load_balancer[:load_balancer_arns] = resource[:load_balancer_arns] unless resource[:load_balancer_arns].nil?
      load_balancer[:name] = resource[:name] unless resource[:name].nil?
      load_balancer[:names] = resource[:names] unless resource[:names].nil?
      load_balancer[:page_size] = resource[:page_size] unless resource[:page_size].nil?
      load_balancer[:scheme] = resource[:scheme] unless resource[:scheme].nil?
      load_balancer[:security_groups] = resource[:security_groups] unless resource[:security_groups].nil?
      load_balancer[:subnet_mappings] = resource[:subnet_mappings] unless resource[:subnet_mappings].nil?
      load_balancer[:subnets] = resource[:subnets] unless resource[:subnets].nil?
      load_balancer[:tags] = resource[:tags] unless resource[:tags].nil?
      load_balancer[:type] = resource[:type] unless resource[:type].nil?
    end
    return symbolize(load_balancer)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info("Calling operation delete_load_balancer")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.get_region)
    client.delete_load_balancer({namevar => @property_hash[namevar]})
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
