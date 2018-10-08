require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-rds"


Puppet::Type.type(:aws_db_subnet_group).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  # RDS Properties
  
  def namevar
    :db_subnet_group_name
  end

  def self.namevar
    :db_subnet_group_name
  end
  
  
  def db_subnet_group_arn=(value)
    Puppet.info("db_subnet_group_arn setter called to change to #{value}")
    @property_flush[:db_subnet_group_arn] = value
  end
    
  
  def db_subnet_group_description=(value)
    Puppet.info("db_subnet_group_description setter called to change to #{value}")
    @property_flush[:db_subnet_group_description] = value
  end
    
  
  def db_subnet_group_name=(value)
    Puppet.info("db_subnet_group_name setter called to change to #{value}")
    @property_flush[:db_subnet_group_name] = value
  end
    
  
  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end
    
  
  def max_records=(value)
    Puppet.info("max_records setter called to change to #{value}")
    @property_flush[:max_records] = value
  end
    
  
  def subnet_group_status=(value)
    Puppet.info("subnet_group_status setter called to change to #{value}")
    @property_flush[:subnet_group_status] = value
  end
    
  
  def subnet_ids=(value)
    Puppet.info("subnet_ids setter called to change to #{value}")
    @property_flush[:subnet_ids] = value
  end
    
  
  def subnets=(value)
    Puppet.info("subnets setter called to change to #{value}")
    @property_flush[:subnets] = value
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
    client.describe_db_subnet_groups.each do |response|
      response.db_subnet_groups.each do |i|
        hash = instance_to_hash(i)
        all_instances << new(hash) if has_name?(hash)
      end
    end
    all_instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      name = prov.property_hash[self.namevar]
      if (resource = (resources.find { |k, v| k.casecmp(name).zero? } || [])[1])
          resource.provider = prov
      end
    end
  end

  def self.instance_to_hash(instance)
  
    db_subnet_group_arn = instance.respond_to?(:db_subnet_group_arn) ? (instance.db_subnet_group_arn.respond_to?(:to_hash) ? instance.db_subnet_group_arn.to_hash : instance.db_subnet_group_arn ) : nil
    db_subnet_group_description = instance.respond_to?(:db_subnet_group_description) ? (instance.db_subnet_group_description.respond_to?(:to_hash) ? instance.db_subnet_group_description.to_hash : instance.db_subnet_group_description ) : nil
    db_subnet_group_name = instance.respond_to?(:db_subnet_group_name) ? (instance.db_subnet_group_name.respond_to?(:to_hash) ? instance.db_subnet_group_name.to_hash : instance.db_subnet_group_name ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records ) : nil
    subnet_group_status = instance.respond_to?(:subnet_group_status) ? (instance.subnet_group_status.respond_to?(:to_hash) ? instance.subnet_group_status.to_hash : instance.subnet_group_status ) : nil
    subnet_ids = instance.respond_to?(:subnet_ids) ? (instance.subnet_ids.respond_to?(:to_hash) ? instance.subnet_ids.to_hash : instance.subnet_ids ) : nil
    subnets = instance.respond_to?(:subnets) ? (instance.subnets.respond_to?(:to_hash) ? instance.subnets.to_hash : instance.subnets ) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags ) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id ) : nil

    db_subnet_group = {}
    db_subnet_group[:ensure] = :present
    db_subnet_group[:object] = instance
    db_subnet_group[:name] = instance.to_hash[self.namevar]
  
    db_subnet_group[:db_subnet_group_arn] = db_subnet_group_arn unless db_subnet_group_arn.nil?
    db_subnet_group[:db_subnet_group_description] = db_subnet_group_description unless db_subnet_group_description.nil?
    db_subnet_group[:db_subnet_group_name] = db_subnet_group_name unless db_subnet_group_name.nil?
    db_subnet_group[:filters] = filters unless filters.nil?
    db_subnet_group[:max_records] = max_records unless max_records.nil?
    db_subnet_group[:subnet_group_status] = subnet_group_status unless subnet_group_status.nil?
    db_subnet_group[:subnet_ids] = subnet_ids unless subnet_ids.nil?
    db_subnet_group[:subnets] = subnets unless subnets.nil?
    db_subnet_group[:tags] = tags unless tags.nil?
    db_subnet_group[:vpc_id] = vpc_id unless vpc_id.nil?
    db_subnet_group
  end

  def build_hash
    db_subnet_group = {}
    if @is_create || @is_update
      db_subnet_group[:db_subnet_group_description] = resource[:db_subnet_group_description] unless resource[:db_subnet_group_description].nil?
      db_subnet_group[:db_subnet_group_name] = resource[:db_subnet_group_name] unless resource[:db_subnet_group_name].nil?
      db_subnet_group[:filters] = resource[:filters] unless resource[:filters].nil?
      db_subnet_group[:max_records] = resource[:max_records] unless resource[:max_records].nil?
      db_subnet_group[:subnet_ids] = resource[:subnet_ids] unless resource[:subnet_ids].nil?
      db_subnet_group[:tags] = resource[:tags] unless resource[:tags].nil?
    end
    db_subnet_group[self.namevar] = resource[:name]
    return symbolize(db_subnet_group)
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    response = client.create_db_subnet_group(build_hash)
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
    Puppet.info("Calling operation delete_db_subnet_group")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    client.delete_db_subnet_group(build_hash)
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
