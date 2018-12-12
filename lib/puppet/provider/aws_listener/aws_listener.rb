require 'json'
require 'retries'

require 'aws-sdk-elasticloadbalancingv2'


Puppet::Type.type(:aws_listener).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end


  # ELB param properties
  def namevar
    :listener_arn
  end


  def certificates=(value)
    Puppet.info("certificates setter called to change to #{value}")
    @property_flush[:certificates] = value
  end

  def default_actions=(value)
    Puppet.info("default_actions setter called to change to #{value}")
    @property_flush[:default_actions] = value
  end

  def listener_arn=(value)
    Puppet.info("listener_arn setter called to change to #{value}")
    @property_flush[:listener_arn] = value
  end

  def listener_arns=(value)
    Puppet.info("listener_arns setter called to change to #{value}")
    @property_flush[:listener_arns] = value
  end

  def load_balancer_arn=(value)
    Puppet.info("load_balancer_arn setter called to change to #{value}")
    @property_flush[:load_balancer_arn] = value
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

  def ssl_policy=(value)
    Puppet.info("ssl_policy setter called to change to #{value}")
    @property_flush[:ssl_policy] = value
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

  attr_reader :property_hash

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Listener")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.region)
    client.create_listener(build_hash)
    @property_hash[:ensure] = :present
  rescue StandardError => ex
    msg = ex.to_s.nil? ? ex.detail : ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{msg} and backtrace is #{ex.backtrace}")
    raise
  end

  def flush
    Puppet.info("Entered flush for resource #{name} of type Listener - creating ? #{@is_create}, deleting ? #{@is_delete}")
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
    listener = {}
    if @is_create || @is_update
      listener[:certificates] = resource[:certificates] unless resource[:certificates].nil?
      listener[:default_actions] = resource[:default_actions] unless resource[:default_actions].nil?
      listener[:listener_arn] = resource[:listener_arn] unless resource[:listener_arn].nil?
      listener[:listener_arns] = resource[:listener_arns] unless resource[:listener_arns].nil?
      listener[:load_balancer_arn] = resource[:load_balancer_arn] unless resource[:load_balancer_arn].nil?
      listener[:page_size] = resource[:page_size] unless resource[:page_size].nil?
      listener[:port] = resource[:port] unless resource[:port].nil?
      listener[:protocol] = resource[:protocol] unless resource[:protocol].nil?
      listener[:ssl_policy] = resource[:ssl_policy] unless resource[:ssl_policy].nil?
    end
    symbolize(listener)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_listener')
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.region)
    client.delete_listener(namevar => @property_hash[namevar])
    @property_hash[:ensure] = :absent
  end
  def exists?
    Puppet.info("Parametered Describe for resource #{name} of type Listener")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.region)
    response = client.describe_listeners(load_balancer_arn: resource.to_hash[:load_balancer_arn])
    @property_hash[:ensure] = :present
    @property_hash[:object] = response.listeners.first
    @property_hash[namevar] = response.listeners.first.to_hash[namevar]
    return true
  rescue StandardError
    return false
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
