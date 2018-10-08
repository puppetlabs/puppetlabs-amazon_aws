require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-rds"


Puppet::Type.type(:aws_db_security_group).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  # RDS Properties
  
  def namevar
    :db_security_group_name
  end

  def self.namevar
    :db_security_group_name
  end
  
  
  def db_security_group_arn=(value)
    Puppet.info("db_security_group_arn setter called to change to #{value}")
    @property_flush[:db_security_group_arn] = value
  end
    
  
  def db_security_group_description=(value)
    Puppet.info("db_security_group_description setter called to change to #{value}")
    @property_flush[:db_security_group_description] = value
  end
    
  
  def db_security_group_name=(value)
    Puppet.info("db_security_group_name setter called to change to #{value}")
    @property_flush[:db_security_group_name] = value
  end
    
  
  def ec2_security_groups=(value)
    Puppet.info("ec2_security_groups setter called to change to #{value}")
    @property_flush[:ec2_security_groups] = value
  end
    
  
  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end
    
  
  def ip_ranges=(value)
    Puppet.info("ip_ranges setter called to change to #{value}")
    @property_flush[:ip_ranges] = value
  end
    
  
  def max_records=(value)
    Puppet.info("max_records setter called to change to #{value}")
    @property_flush[:max_records] = value
  end
    
  
  def owner_id=(value)
    Puppet.info("owner_id setter called to change to #{value}")
    @property_flush[:owner_id] = value
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
    client.describe_db_security_groups.each do |response|
      response.db_security_groups.each do |i|
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
  
    db_security_group_arn = instance.respond_to?(:db_security_group_arn) ? (instance.db_security_group_arn.respond_to?(:to_hash) ? instance.db_security_group_arn.to_hash : instance.db_security_group_arn ) : nil
    db_security_group_description = instance.respond_to?(:db_security_group_description) ? (instance.db_security_group_description.respond_to?(:to_hash) ? instance.db_security_group_description.to_hash : instance.db_security_group_description ) : nil
    db_security_group_name = instance.respond_to?(:db_security_group_name) ? (instance.db_security_group_name.respond_to?(:to_hash) ? instance.db_security_group_name.to_hash : instance.db_security_group_name ) : nil
    ec2_security_groups = instance.respond_to?(:ec2_security_groups) ? (instance.ec2_security_groups.respond_to?(:to_hash) ? instance.ec2_security_groups.to_hash : instance.ec2_security_groups ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    ip_ranges = instance.respond_to?(:ip_ranges) ? (instance.ip_ranges.respond_to?(:to_hash) ? instance.ip_ranges.to_hash : instance.ip_ranges ) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records ) : nil
    owner_id = instance.respond_to?(:owner_id) ? (instance.owner_id.respond_to?(:to_hash) ? instance.owner_id.to_hash : instance.owner_id ) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags ) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id ) : nil

    db_security_group = {}
    db_security_group[:ensure] = :present
    db_security_group[:object] = instance
    db_security_group[:name] = instance.to_hash[self.namevar]
  
    db_security_group[:db_security_group_arn] = db_security_group_arn unless db_security_group_arn.nil?
    db_security_group[:db_security_group_description] = db_security_group_description unless db_security_group_description.nil?
    db_security_group[:db_security_group_name] = db_security_group_name unless db_security_group_name.nil?
    db_security_group[:ec2_security_groups] = ec2_security_groups unless ec2_security_groups.nil?
    db_security_group[:filters] = filters unless filters.nil?
    db_security_group[:ip_ranges] = ip_ranges unless ip_ranges.nil?
    db_security_group[:max_records] = max_records unless max_records.nil?
    db_security_group[:owner_id] = owner_id unless owner_id.nil?
    db_security_group[:tags] = tags unless tags.nil?
    db_security_group[:vpc_id] = vpc_id unless vpc_id.nil?
    db_security_group
  end

  def build_hash
    db_security_group = {}
    if @is_create || @is_update
      db_security_group[:db_security_group_description] = resource[:db_security_group_description] unless resource[:db_security_group_description].nil?
      db_security_group[:db_security_group_name] = resource[:db_security_group_name] unless resource[:db_security_group_name].nil?
      db_security_group[:filters] = resource[:filters] unless resource[:filters].nil?
      db_security_group[:max_records] = resource[:max_records] unless resource[:max_records].nil?
      db_security_group[:tags] = resource[:tags] unless resource[:tags].nil?
    end
    db_security_group[self.namevar] = resource[:name]
    return symbolize(db_security_group)
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    response = client.create_db_security_group(build_hash)
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
    Puppet.info("Calling operation delete_db_security_group")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    client.delete_db_security_group(build_hash)
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
