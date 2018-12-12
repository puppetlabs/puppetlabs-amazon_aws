require 'json'
require 'retries'

require 'aws-sdk-elasticloadbalancingv2'


Puppet::Type.type(:aws_target_group).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end


  # ELB Target Group Properties
  def namevar
    :target_group_arn
  end

  def self.namevar
    :target_group_arn
  end

  # Properties

  def health_check_enabled=(value)
    Puppet.info("health_check_enabled setter called to change to #{value}")
    @property_flush[:health_check_enabled] = value
  end

  def health_check_interval_seconds=(value)
    Puppet.info("health_check_interval_seconds setter called to change to #{value}")
    @property_flush[:health_check_interval_seconds] = value
  end

  def health_check_path=(value)
    Puppet.info("health_check_path setter called to change to #{value}")
    @property_flush[:health_check_path] = value
  end

  def health_check_port=(value)
    Puppet.info("health_check_port setter called to change to #{value}")
    @property_flush[:health_check_port] = value
  end

  def health_check_protocol=(value)
    Puppet.info("health_check_protocol setter called to change to #{value}")
    @property_flush[:health_check_protocol] = value
  end

  def health_check_timeout_seconds=(value)
    Puppet.info("health_check_timeout_seconds setter called to change to #{value}")
    @property_flush[:health_check_timeout_seconds] = value
  end

  def healthy_threshold_count=(value)
    Puppet.info("healthy_threshold_count setter called to change to #{value}")
    @property_flush[:healthy_threshold_count] = value
  end

  def load_balancer_arn=(value)
    Puppet.info("load_balancer_arn setter called to change to #{value}")
    @property_flush[:load_balancer_arn] = value
  end

  def matcher=(value)
    Puppet.info("matcher setter called to change to #{value}")
    @property_flush[:matcher] = value
  end

  def names=(value)
    Puppet.info("names setter called to change to #{value}")
    @property_flush[:names] = value
  end

  def page_size=(value)
    Puppet.info("page_size setter called to change to #{value}")
    @property_flush[:page_size] = value
  end

  def port=(value)
    Puppet.info("port setter called to change to #{value}")
    @property_flush[:port] = value
  end

  def protocol=(value)
    Puppet.info("protocol setter called to change to #{value}")
    @property_flush[:protocol] = value
  end

  def target_group_arn=(value)
    Puppet.info("target_group_arn setter called to change to #{value}")
    @property_flush[:target_group_arn] = value
  end

  def target_group_arns=(value)
    Puppet.info("target_group_arns setter called to change to #{value}")
    @property_flush[:target_group_arns] = value
  end

  def target_type=(value)
    Puppet.info("target_type setter called to change to #{value}")
    @property_flush[:target_type] = value
  end

  def unhealthy_threshold_count=(value)
    Puppet.info("unhealthy_threshold_count setter called to change to #{value}")
    @property_flush[:unhealthy_threshold_count] = value
  end

  def vpc_id=(value)
    Puppet.info("vpc_id setter called to change to #{value}")
    @property_flush[:vpc_id] = value
  end


  def name=(value)
    Puppet.info("name setter called to change to #{value}")
    @property_flush[:name] = value
  end

  attr_reader :property_hash

  def self.region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def self.name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end
  def self.instances
    Puppet.debug("Calling instances for region #{region}")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: region)

    all_instances = []
    client.describe_target_groups.each do |response|
      response.target_groups.each do |i|
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
    health_check_enabled = instance.respond_to?(:health_check_enabled) ? (instance.health_check_enabled.respond_to?(:to_hash) ? instance.health_check_enabled.to_hash : instance.health_check_enabled) : nil
    health_check_interval_seconds = instance.respond_to?(:health_check_interval_seconds) ? (instance.health_check_interval_seconds.respond_to?(:to_hash) ? instance.health_check_interval_seconds.to_hash : instance.health_check_interval_seconds) : nil
    health_check_path = instance.respond_to?(:health_check_path) ? (instance.health_check_path.respond_to?(:to_hash) ? instance.health_check_path.to_hash : instance.health_check_path) : nil
    health_check_port = instance.respond_to?(:health_check_port) ? (instance.health_check_port.respond_to?(:to_hash) ? instance.health_check_port.to_hash : instance.health_check_port) : nil
    health_check_protocol = instance.respond_to?(:health_check_protocol) ? (instance.health_check_protocol.respond_to?(:to_hash) ? instance.health_check_protocol.to_hash : instance.health_check_protocol) : nil
    health_check_timeout_seconds = instance.respond_to?(:health_check_timeout_seconds) ? (instance.health_check_timeout_seconds.respond_to?(:to_hash) ? instance.health_check_timeout_seconds.to_hash : instance.health_check_timeout_seconds) : nil
    healthy_threshold_count = instance.respond_to?(:healthy_threshold_count) ? (instance.healthy_threshold_count.respond_to?(:to_hash) ? instance.healthy_threshold_count.to_hash : instance.healthy_threshold_count) : nil
    load_balancer_arn = instance.respond_to?(:load_balancer_arn) ? (instance.load_balancer_arn.respond_to?(:to_hash) ? instance.load_balancer_arn.to_hash : instance.load_balancer_arn) : nil
    matcher = instance.respond_to?(:matcher) ? (instance.matcher.respond_to?(:to_hash) ? instance.matcher.to_hash : instance.matcher) : nil
    names = instance.respond_to?(:names) ? (instance.names.respond_to?(:to_hash) ? instance.names.to_hash : instance.names) : nil
    page_size = instance.respond_to?(:page_size) ? (instance.page_size.respond_to?(:to_hash) ? instance.page_size.to_hash : instance.page_size) : nil
    port = instance.respond_to?(:port) ? (instance.port.respond_to?(:to_hash) ? instance.port.to_hash : instance.port) : nil
    protocol = instance.respond_to?(:protocol) ? (instance.protocol.respond_to?(:to_hash) ? instance.protocol.to_hash : instance.protocol) : nil
    target_group_arn = instance.respond_to?(:target_group_arn) ? (instance.target_group_arn.respond_to?(:to_hash) ? instance.target_group_arn.to_hash : instance.target_group_arn) : nil
    target_group_arns = instance.respond_to?(:target_group_arns) ? (instance.target_group_arns.respond_to?(:to_hash) ? instance.target_group_arns.to_hash : instance.target_group_arns) : nil
    target_type = instance.respond_to?(:target_type) ? (instance.target_type.respond_to?(:to_hash) ? instance.target_type.to_hash : instance.target_type) : nil
    unhealthy_threshold_count = instance.respond_to?(:unhealthy_threshold_count) ? (instance.unhealthy_threshold_count.respond_to?(:to_hash) ? instance.unhealthy_threshold_count.to_hash : instance.unhealthy_threshold_count) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = instance[:target_group_name]
    hash[:target_group_name] = instance[:target_group_name]


    hash[:health_check_enabled] = health_check_enabled unless health_check_enabled.nil?
    hash[:health_check_interval_seconds] = health_check_interval_seconds unless health_check_interval_seconds.nil?
    hash[:health_check_path] = health_check_path unless health_check_path.nil?
    hash[:health_check_port] = health_check_port unless health_check_port.nil?
    hash[:health_check_protocol] = health_check_protocol unless health_check_protocol.nil?
    hash[:health_check_timeout_seconds] = health_check_timeout_seconds unless health_check_timeout_seconds.nil?
    hash[:healthy_threshold_count] = healthy_threshold_count unless healthy_threshold_count.nil?
    hash[:load_balancer_arn] = load_balancer_arn unless load_balancer_arn.nil?
    hash[:matcher] = matcher unless matcher.nil?
    hash[:names] = names unless names.nil?
    hash[:page_size] = page_size unless page_size.nil?
    hash[:port] = port unless port.nil?
    hash[:protocol] = protocol unless protocol.nil?
    hash[:target_group_arn] = target_group_arn unless target_group_arn.nil?
    hash[:target_group_arns] = target_group_arns unless target_group_arns.nil?
    hash[:target_type] = target_type unless target_type.nil?
    hash[:unhealthy_threshold_count] = unhealthy_threshold_count unless unhealthy_threshold_count.nil?
    hash[:vpc_id] = vpc_id unless vpc_id.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.region)
    client.create_target_group(build_hash)
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
    target_group = {}
    if @is_create || @is_update
      target_group[:health_check_enabled] = resource[:health_check_enabled] unless resource[:health_check_enabled].nil?
      target_group[:health_check_interval_seconds] = resource[:health_check_interval_seconds] unless resource[:health_check_interval_seconds].nil?
      target_group[:health_check_path] = resource[:health_check_path] unless resource[:health_check_path].nil?
      target_group[:health_check_port] = resource[:health_check_port] unless resource[:health_check_port].nil?
      target_group[:health_check_protocol] = resource[:health_check_protocol] unless resource[:health_check_protocol].nil?
      target_group[:health_check_timeout_seconds] = resource[:health_check_timeout_seconds] unless resource[:health_check_timeout_seconds].nil?
      target_group[:healthy_threshold_count] = resource[:healthy_threshold_count] unless resource[:healthy_threshold_count].nil?
      target_group[:vpc_id] = resource[:vpc_id] unless resource[:vpc_id].nil?
      target_group[:load_balancer_arn] = resource[:load_balancer_arn] unless resource[:load_balancer_arn].nil?
      target_group[:matcher] = resource[:matcher] unless resource[:matcher].nil?
      target_group[:name] = resource[:name] unless resource[:name].nil?
      target_group[:names] = resource[:names] unless resource[:names].nil?
      target_group[:page_size] = resource[:page_size] unless resource[:page_size].nil?
      target_group[:port] = resource[:port] unless resource[:port].nil?
      target_group[:protocol] = resource[:protocol] unless resource[:protocol].nil?
      target_group[:target_group_arn] = resource[:target_group_arn] unless resource[:target_group_arn].nil?
      target_group[:target_group_arns] = resource[:target_group_arns] unless resource[:target_group_arns].nil?
      target_group[:target_type] = resource[:target_type] unless resource[:target_type].nil?
      target_group[:unhealthy_threshold_count] = resource[:unhealthy_threshold_count] unless resource[:unhealthy_threshold_count].nil?
      target_group[:vpc_id] = resource[:vpc_id] unless resource[:vpc_id].nil?
    end
    symbolize(target_group)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_target_group')
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.region)
    client.delete_target_group(namevar => @property_hash[namevar])
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
