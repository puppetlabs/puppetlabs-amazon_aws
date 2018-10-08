require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-rds"


Puppet::Type.type(:aws_db_parameter_group).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  # RDS Properties
  
  def namevar
    :db_parameter_group_name
  end

  def self.namevar
    :db_parameter_group_name
  end
  
  
  def db_parameter_group_arn=(value)
    Puppet.info("db_parameter_group_arn setter called to change to #{value}")
    @property_flush[:db_parameter_group_arn] = value
  end
    
  
  def db_parameter_group_family=(value)
    Puppet.info("db_parameter_group_family setter called to change to #{value}")
    @property_flush[:db_parameter_group_family] = value
  end
    
  
  def db_parameter_group_name=(value)
    Puppet.info("db_parameter_group_name setter called to change to #{value}")
    @property_flush[:db_parameter_group_name] = value
  end
    
  
  def description=(value)
    Puppet.info("description setter called to change to #{value}")
    @property_flush[:description] = value
  end
    
  
  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end
    
  
  def max_records=(value)
    Puppet.info("max_records setter called to change to #{value}")
    @property_flush[:max_records] = value
  end
    
  
  def parameters=(value)
    Puppet.info("parameters setter called to change to #{value}")
    @property_flush[:parameters] = value
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
    client.describe_db_parameter_groups.each do |response|
      response.db_parameter_groups.each do |i|
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
  
    db_parameter_group_arn = instance.respond_to?(:db_parameter_group_arn) ? (instance.db_parameter_group_arn.respond_to?(:to_hash) ? instance.db_parameter_group_arn.to_hash : instance.db_parameter_group_arn ) : nil
    db_parameter_group_family = instance.respond_to?(:db_parameter_group_family) ? (instance.db_parameter_group_family.respond_to?(:to_hash) ? instance.db_parameter_group_family.to_hash : instance.db_parameter_group_family ) : nil
    db_parameter_group_name = instance.respond_to?(:db_parameter_group_name) ? (instance.db_parameter_group_name.respond_to?(:to_hash) ? instance.db_parameter_group_name.to_hash : instance.db_parameter_group_name ) : nil
    description = instance.respond_to?(:description) ? (instance.description.respond_to?(:to_hash) ? instance.description.to_hash : instance.description ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records ) : nil
    parameters = instance.respond_to?(:parameters) ? (instance.parameters.respond_to?(:to_hash) ? instance.parameters.to_hash : instance.parameters ) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags ) : nil

    db_parameter_group = {}
    db_parameter_group[:ensure] = :present
    db_parameter_group[:object] = instance
    db_parameter_group[:name] = instance.to_hash[self.namevar]
  
    db_parameter_group[:db_parameter_group_arn] = db_parameter_group_arn unless db_parameter_group_arn.nil?
    db_parameter_group[:db_parameter_group_family] = db_parameter_group_family unless db_parameter_group_family.nil?
    db_parameter_group[:db_parameter_group_name] = db_parameter_group_name unless db_parameter_group_name.nil?
    db_parameter_group[:description] = description unless description.nil?
    db_parameter_group[:filters] = filters unless filters.nil?
    db_parameter_group[:max_records] = max_records unless max_records.nil?
    db_parameter_group[:parameters] = parameters unless parameters.nil?
    db_parameter_group[:tags] = tags unless tags.nil?
    db_parameter_group
  end

  def build_hash
    db_parameter_group = {}
    if @is_create || @is_update
      db_parameter_group[:db_parameter_group_family] = resource[:db_parameter_group_family] unless resource[:db_parameter_group_family].nil?
      db_parameter_group[:db_parameter_group_name] = resource[:db_parameter_group_name] unless resource[:db_parameter_group_name].nil?
      db_parameter_group[:description] = resource[:description] unless resource[:description].nil?
      db_parameter_group[:filters] = resource[:filters] unless resource[:filters].nil?
      db_parameter_group[:max_records] = resource[:max_records] unless resource[:max_records].nil?
      db_parameter_group[:parameters] = resource[:parameters] unless resource[:parameters].nil?
      db_parameter_group[:tags] = resource[:tags] unless resource[:tags].nil?
    end
    db_parameter_group[self.namevar] = resource[:name]
    return symbolize(db_parameter_group)
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    response = client.create_db_parameter_group(build_hash)
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
    Puppet.info("Calling operation delete_db_parameter_group")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    client.delete_db_parameter_group(build_hash)
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
