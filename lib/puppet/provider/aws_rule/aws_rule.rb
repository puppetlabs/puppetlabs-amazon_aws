require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-elasticloadbalancingv2"


Puppet::Type.type(:aws_rule).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  
  # ELB properties
  def namevar
    :rule_arn
  end


  def actions=(value)
    Puppet.info("actions setter called to change to #{value}")
    @property_flush[:actions] = value
  end
  

  def conditions=(value)
    Puppet.info("conditions setter called to change to #{value}")
    @property_flush[:conditions] = value
  end
  

  def listener_arn=(value)
    Puppet.info("listener_arn setter called to change to #{value}")
    @property_flush[:listener_arn] = value
  end
  

  def page_size=(value)
    Puppet.info("page_size setter called to change to #{value}")
    @property_flush[:page_size] = value
  end
  

  def priority=(value)
    Puppet.info("priority setter called to change to #{value}")
    @property_flush[:priority] = value
  end
  

  def rule_arn=(value)
    Puppet.info("rule_arn setter called to change to #{value}")
    @property_flush[:rule_arn] = value
  end
  

  def rule_arns=(value)
    Puppet.info("rule_arns setter called to change to #{value}")
    @property_flush[:rule_arns] = value
  end
  
def name=(value)
    Puppet.info("name setter called to change to #{value}")
    @property_flush[:name] = value
  end

  def self.get_region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def self.has_name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end

  def property_hash
    @property_hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Rule")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.get_region)
    client.create_rule(build_hash)
    @property_hash[:ensure] = :present
  rescue Exception => ex
    msg = ex.to_s.nil? ? ex.detail : ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{msg} and backtrace is #{ex.backtrace}")
    raise
  end

  def flush
    Puppet.info("Entered flush for resource #{name} of type Rule - creating ? #{@is_create}, deleting ? #{@is_delete}")
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
    rule = {}
    if @is_create || @is_update
      rule[:actions] = resource[:actions] unless resource[:actions].nil?
      rule[:conditions] = resource[:conditions] unless resource[:conditions].nil?
      rule[:listener_arn] = resource[:listener_arn] unless resource[:listener_arn].nil?
      rule[:page_size] = resource[:page_size] unless resource[:page_size].nil?
      rule[:priority] = resource[:priority] unless resource[:priority].nil?
      rule[:rule_arn] = resource[:rule_arn] unless resource[:rule_arn].nil?
      rule[:rule_arns] = resource[:rule_arns] unless resource[:rule_arns].nil?
    end
    return symbolize(rule)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info("Calling operation delete_rule")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.get_region)
    client.delete_rule({namevar => @property_hash[namevar]})
    @property_hash[:ensure] = :absent
  end
  def exists?
    Puppet.info("Parametered Describe for resource #{name} of type Rule")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: self.class.get_region)
    response = client.describe_rules({:listener_arn => resource.to_hash[:listener_arn]})
    @property_hash[:ensure] = :present
    @property_hash[:object] = response.rules.first
    @property_hash[namevar] = response.rules.first.to_hash[namevar]
    return true
  rescue Exception => ex
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
