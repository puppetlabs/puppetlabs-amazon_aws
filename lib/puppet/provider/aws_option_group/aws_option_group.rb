require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-rds"


Puppet::Type.type(:aws_option_group).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  # RDS Properties
  
  def namevar
    :option_group_name
  end

  def self.namevar
    :option_group_name
  end
  
  
  def allows_vpc_and_non_vpc_instance_memberships=(value)
    Puppet.info("allows_vpc_and_non_vpc_instance_memberships setter called to change to #{value}")
    @property_flush[:allows_vpc_and_non_vpc_instance_memberships] = value
  end
    
  
  def apply_immediately=(value)
    Puppet.info("apply_immediately setter called to change to #{value}")
    @property_flush[:apply_immediately] = value
  end
    
  
  def engine_name=(value)
    Puppet.info("engine_name setter called to change to #{value}")
    @property_flush[:engine_name] = value
  end
    
  
  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end
    
  
  def major_engine_version=(value)
    Puppet.info("major_engine_version setter called to change to #{value}")
    @property_flush[:major_engine_version] = value
  end
    
  
  def max_records=(value)
    Puppet.info("max_records setter called to change to #{value}")
    @property_flush[:max_records] = value
  end
    
  
  def option_group_arn=(value)
    Puppet.info("option_group_arn setter called to change to #{value}")
    @property_flush[:option_group_arn] = value
  end
    
  
  def option_group_description=(value)
    Puppet.info("option_group_description setter called to change to #{value}")
    @property_flush[:option_group_description] = value
  end
    
  
  def option_group_name=(value)
    Puppet.info("option_group_name setter called to change to #{value}")
    @property_flush[:option_group_name] = value
  end
    
  
  def options=(value)
    Puppet.info("options setter called to change to #{value}")
    @property_flush[:options] = value
  end
    
  
  def options_to_include=(value)
    Puppet.info("options_to_include setter called to change to #{value}")
    @property_flush[:options_to_include] = value
  end
    
  
  def options_to_remove=(value)
    Puppet.info("options_to_remove setter called to change to #{value}")
    @property_flush[:options_to_remove] = value
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
    client.describe_option_groups.each do |response|
      response.option_groups_list.each do |i|
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
  
    allows_vpc_and_non_vpc_instance_memberships = instance.respond_to?(:allows_vpc_and_non_vpc_instance_memberships) ? (instance.allows_vpc_and_non_vpc_instance_memberships.respond_to?(:to_hash) ? instance.allows_vpc_and_non_vpc_instance_memberships.to_hash : instance.allows_vpc_and_non_vpc_instance_memberships ) : nil
    apply_immediately = instance.respond_to?(:apply_immediately) ? (instance.apply_immediately.respond_to?(:to_hash) ? instance.apply_immediately.to_hash : instance.apply_immediately ) : nil
    engine_name = instance.respond_to?(:engine_name) ? (instance.engine_name.respond_to?(:to_hash) ? instance.engine_name.to_hash : instance.engine_name ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    major_engine_version = instance.respond_to?(:major_engine_version) ? (instance.major_engine_version.respond_to?(:to_hash) ? instance.major_engine_version.to_hash : instance.major_engine_version ) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records ) : nil
    option_group_arn = instance.respond_to?(:option_group_arn) ? (instance.option_group_arn.respond_to?(:to_hash) ? instance.option_group_arn.to_hash : instance.option_group_arn ) : nil
    option_group_description = instance.respond_to?(:option_group_description) ? (instance.option_group_description.respond_to?(:to_hash) ? instance.option_group_description.to_hash : instance.option_group_description ) : nil
    option_group_name = instance.respond_to?(:option_group_name) ? (instance.option_group_name.respond_to?(:to_hash) ? instance.option_group_name.to_hash : instance.option_group_name ) : nil
    options = instance.respond_to?(:options) ? (instance.options.respond_to?(:to_hash) ? instance.options.to_hash : instance.options ) : nil
    options_to_include = instance.respond_to?(:options_to_include) ? (instance.options_to_include.respond_to?(:to_hash) ? instance.options_to_include.to_hash : instance.options_to_include ) : nil
    options_to_remove = instance.respond_to?(:options_to_remove) ? (instance.options_to_remove.respond_to?(:to_hash) ? instance.options_to_remove.to_hash : instance.options_to_remove ) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags ) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id ) : nil

    option_group = {}
    option_group[:ensure] = :present
    option_group[:object] = instance
    option_group[:name] = instance.to_hash[self.namevar]
  
    option_group[:allows_vpc_and_non_vpc_instance_memberships] = allows_vpc_and_non_vpc_instance_memberships unless allows_vpc_and_non_vpc_instance_memberships.nil?
    option_group[:apply_immediately] = apply_immediately unless apply_immediately.nil?
    option_group[:engine_name] = engine_name unless engine_name.nil?
    option_group[:filters] = filters unless filters.nil?
    option_group[:major_engine_version] = major_engine_version unless major_engine_version.nil?
    option_group[:max_records] = max_records unless max_records.nil?
    option_group[:option_group_arn] = option_group_arn unless option_group_arn.nil?
    option_group[:option_group_description] = option_group_description unless option_group_description.nil?
    option_group[:option_group_name] = option_group_name unless option_group_name.nil?
    option_group[:options] = options unless options.nil?
    option_group[:options_to_include] = options_to_include unless options_to_include.nil?
    option_group[:options_to_remove] = options_to_remove unless options_to_remove.nil?
    option_group[:tags] = tags unless tags.nil?
    option_group[:vpc_id] = vpc_id unless vpc_id.nil?
    option_group
  end

  def build_hash
    option_group = {}
    if @is_create || @is_update
      option_group[:apply_immediately] = resource[:apply_immediately] unless resource[:apply_immediately].nil?
      option_group[:engine_name] = resource[:engine_name] unless resource[:engine_name].nil?
      option_group[:filters] = resource[:filters] unless resource[:filters].nil?
      option_group[:major_engine_version] = resource[:major_engine_version] unless resource[:major_engine_version].nil?
      option_group[:max_records] = resource[:max_records] unless resource[:max_records].nil?
      option_group[:option_group_description] = resource[:option_group_description] unless resource[:option_group_description].nil?
      option_group[:option_group_name] = resource[:option_group_name] unless resource[:option_group_name].nil?
      option_group[:options_to_include] = resource[:options_to_include] unless resource[:options_to_include].nil?
      option_group[:options_to_remove] = resource[:options_to_remove] unless resource[:options_to_remove].nil?
      option_group[:tags] = resource[:tags] unless resource[:tags].nil?
    end
    option_group[self.namevar] = resource[:name]
    return symbolize(option_group)
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    response = client.create_option_group(build_hash)
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
    Puppet.info("Calling operation delete_option_group")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    client.delete_option_group(build_hash)
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
