require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-rds"


Puppet::Type.type(:aws_event_subscription).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  # ProviderRDS Event Subscription Properties
  
  def namevar
    :subscription_name
  end

  def self.namevar
    :subscription_name
  end
  
  
  def customer_aws_id=(value)
    Puppet.info("customer_aws_id setter called to change to #{value}")
    @property_flush[:customer_aws_id] = value
  end
    
  
  def cust_subscription_id=(value)
    Puppet.info("cust_subscription_id setter called to change to #{value}")
    @property_flush[:cust_subscription_id] = value
  end
    
  
  def enabled=(value)
    Puppet.info("enabled setter called to change to #{value}")
    @property_flush[:enabled] = value
  end
    
  
  def event_categories=(value)
    Puppet.info("event_categories setter called to change to #{value}")
    @property_flush[:event_categories] = value
  end
    
  
  def event_categories_list=(value)
    Puppet.info("event_categories_list setter called to change to #{value}")
    @property_flush[:event_categories_list] = value
  end
    
  
  def event_subscription_arn=(value)
    Puppet.info("event_subscription_arn setter called to change to #{value}")
    @property_flush[:event_subscription_arn] = value
  end
    
  
  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end
    
  
  def max_records=(value)
    Puppet.info("max_records setter called to change to #{value}")
    @property_flush[:max_records] = value
  end
    
  
  def sns_topic_arn=(value)
    Puppet.info("sns_topic_arn setter called to change to #{value}")
    @property_flush[:sns_topic_arn] = value
  end
    
  
  def source_ids=(value)
    Puppet.info("source_ids setter called to change to #{value}")
    @property_flush[:source_ids] = value
  end
    
  
  def source_ids_list=(value)
    Puppet.info("source_ids_list setter called to change to #{value}")
    @property_flush[:source_ids_list] = value
  end
    
  
  def source_type=(value)
    Puppet.info("source_type setter called to change to #{value}")
    @property_flush[:source_type] = value
  end
    
  
  def status=(value)
    Puppet.info("status setter called to change to #{value}")
    @property_flush[:status] = value
  end
    
  
  def subscription_creation_time=(value)
    Puppet.info("subscription_creation_time setter called to change to #{value}")
    @property_flush[:subscription_creation_time] = value
  end
    
  
  def subscription_name=(value)
    Puppet.info("subscription_name setter called to change to #{value}")
    @property_flush[:subscription_name] = value
  end
    
  
  def tags=(value)
    Puppet.info("tags setter called to change to #{value}")
    @property_flush[:tags] = value
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

  def self.has_name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end
  def self.instances
    Puppet.debug("Calling instances for region #{self.get_region}")
    client = Aws::RDS::Client.new(region: self.get_region)

    all_instances = []
    client.describe_event_subscriptions.each do |response|
      response.event_subscriptions_list.each do |i|
        hash = instance_to_hash(i)
        all_instances << new(hash) if has_name?(hash)
      end
    end
    all_instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      name = prov.property_hash[:cust_subscription_id]
      if (resource = (resources.find { |k, v| k.casecmp(name).zero? } || [])[1])
          resource.provider = prov
      end
    end
  end

  def self.instance_to_hash(instance)
  
    customer_aws_id = instance.respond_to?(:customer_aws_id) ? (instance.customer_aws_id.respond_to?(:to_hash) ? instance.customer_aws_id.to_hash : instance.customer_aws_id ) : nil
    cust_subscription_id = instance.respond_to?(:cust_subscription_id) ? (instance.cust_subscription_id.respond_to?(:to_hash) ? instance.cust_subscription_id.to_hash : instance.cust_subscription_id ) : nil
    enabled = instance.respond_to?(:enabled) ? (instance.enabled.respond_to?(:to_hash) ? instance.enabled.to_hash : instance.enabled ) : nil
    event_categories = instance.respond_to?(:event_categories) ? (instance.event_categories.respond_to?(:to_hash) ? instance.event_categories.to_hash : instance.event_categories ) : nil
    event_categories_list = instance.respond_to?(:event_categories_list) ? (instance.event_categories_list.respond_to?(:to_hash) ? instance.event_categories_list.to_hash : instance.event_categories_list ) : nil
    event_subscription_arn = instance.respond_to?(:event_subscription_arn) ? (instance.event_subscription_arn.respond_to?(:to_hash) ? instance.event_subscription_arn.to_hash : instance.event_subscription_arn ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records ) : nil
    sns_topic_arn = instance.respond_to?(:sns_topic_arn) ? (instance.sns_topic_arn.respond_to?(:to_hash) ? instance.sns_topic_arn.to_hash : instance.sns_topic_arn ) : nil
    source_ids = instance.respond_to?(:source_ids) ? (instance.source_ids.respond_to?(:to_hash) ? instance.source_ids.to_hash : instance.source_ids ) : nil
    source_ids_list = instance.respond_to?(:source_ids_list) ? (instance.source_ids_list.respond_to?(:to_hash) ? instance.source_ids_list.to_hash : instance.source_ids_list ) : nil
    source_type = instance.respond_to?(:source_type) ? (instance.source_type.respond_to?(:to_hash) ? instance.source_type.to_hash : instance.source_type ) : nil
    status = instance.respond_to?(:status) ? (instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status ) : nil
    subscription_creation_time = instance.respond_to?(:subscription_creation_time) ? (instance.subscription_creation_time.respond_to?(:to_hash) ? instance.subscription_creation_time.to_hash : instance.subscription_creation_time ) : nil
    subscription_name = instance.respond_to?(:subscription_name) ? (instance.subscription_name.respond_to?(:to_hash) ? instance.subscription_name.to_hash : instance.subscription_name ) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags ) : nil

    event_subscription = {}
    event_subscription[:ensure] = :present
    event_subscription[:object] = instance
    event_subscription[:name] = instance.to_hash[:cust_subscription_id]
  
    event_subscription[:customer_aws_id] = customer_aws_id unless customer_aws_id.nil?
    event_subscription[:cust_subscription_id] = cust_subscription_id unless cust_subscription_id.nil?
    event_subscription[:enabled] = enabled unless enabled.nil?
    event_subscription[:event_categories] = event_categories unless event_categories.nil?
    event_subscription[:event_categories_list] = event_categories_list unless event_categories_list.nil?
    event_subscription[:event_subscription_arn] = event_subscription_arn unless event_subscription_arn.nil?
    event_subscription[:filters] = filters unless filters.nil?
    event_subscription[:max_records] = max_records unless max_records.nil?
    event_subscription[:sns_topic_arn] = sns_topic_arn unless sns_topic_arn.nil?
    event_subscription[:source_ids] = source_ids unless source_ids.nil?
    event_subscription[:source_ids_list] = source_ids_list unless source_ids_list.nil?
    event_subscription[:source_type] = source_type unless source_type.nil?
    event_subscription[:status] = status unless status.nil?
    event_subscription[:subscription_creation_time] = subscription_creation_time unless subscription_creation_time.nil?
    event_subscription[:subscription_name] = subscription_name unless subscription_name.nil?
    event_subscription[:tags] = tags unless tags.nil?
    event_subscription
  end

  def build_hash
    event_subscription = {}
    if @is_create || @is_update
      event_subscription[:enabled] = resource[:enabled] unless resource[:enabled].nil?
      event_subscription[:event_categories] = resource[:event_categories] unless resource[:event_categories].nil?
      event_subscription[:filters] = resource[:filters] unless resource[:filters].nil?
      event_subscription[:max_records] = resource[:max_records] unless resource[:max_records].nil?
      event_subscription[:subscription_name] = resource[:subscription_name] unless resource[:subscription_name].nil?
      event_subscription[:sns_topic_arn] = resource[:sns_topic_arn] unless resource[:sns_topic_arn].nil?
      event_subscription[:source_ids] = resource[:source_ids] unless resource[:source_ids].nil?
      event_subscription[:source_type] = resource[:source_type] unless resource[:source_type].nil?
      event_subscription[:subscription_name] = resource[:subscription_name] unless resource[:subscription_name].nil?
      event_subscription[:tags] = resource[:tags] unless resource[:tags].nil?
    end
    event_subscription[self.namevar] = resource[:name]
    return symbolize(event_subscription)
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    response = client.create_event_subscription(build_hash)
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
    @property_hash[:ensure] = :present
    response = []
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info("Calling operation delete_event_subscription")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    client.delete_event_subscription(build_hash)
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
