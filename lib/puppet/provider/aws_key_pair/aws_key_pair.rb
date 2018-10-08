require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-ec2"


Puppet::Type.type(:aws_key_pair).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  

  def namevar
    :key_name
    
  end

  def self.namevar
    :key_name
    
  end

  # Properties

  def dry_run=(value)
    Puppet.info("dry_run setter called to change to #{value}")
    @property_flush[:dry_run] = value
  end
  

  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end
  

  def key_name=(value)
    Puppet.info("key_name setter called to change to #{value}")
    @property_flush[:key_name] = value
  end
  

  def key_names=(value)
    Puppet.info("key_names setter called to change to #{value}")
    @property_flush[:key_names] = value
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
    !hash[self.namevar].nil? && !hash[self.namevar].empty?
  end
  def self.instances
    Puppet.debug("Calling instances for region #{self.get_region}")
    client = Aws::EC2::Client.new(region: self.get_region)

    all_instances = []
    client.describe_key_pairs.each do |response|
      response.key_pairs.each do |i|
        hash = instance_to_hash(i)
        all_instances << new(hash) if has_name?(hash)
      end
    end
    all_instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if (resource = (resources.find { |k, v| k.casecmp(prov.property_hash[namevar]).zero? } || [])[1])
        resource.provider = prov
      end
    end
  end


  def self.instance_to_hash(instance)

    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    key_name = instance.respond_to?(:key_name) ? (instance.key_name.respond_to?(:to_hash) ? instance.key_name.to_hash : instance.key_name ) : nil
    key_names = instance.respond_to?(:key_names) ? (instance.key_names.respond_to?(:to_hash) ? instance.key_names.to_hash : instance.key_names ) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = instance.to_hash[namevar]
    hash[:tags] = instance.tags if instance.respond_to?(:tags) and instance.tags.size > 0
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) and instance.tag_set.size > 0

    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:key_name] = key_name unless key_name.nil?
    hash[:key_names] = key_names unless key_names.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EC2::Client.new(region: self.class.get_region)
    client.create_key_pair(build_hash)
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
    key_pair = {}
    if @is_create || @is_update
      key_pair[:dry_run] = resource[:dry_run] unless resource[:dry_run].nil?
      key_pair[:filters] = resource[:filters] unless resource[:filters].nil?
      key_pair[:key_name] = resource[:key_name] unless resource[:key_name].nil?
      key_pair[:key_names] = resource[:key_names] unless resource[:key_names].nil?
      key_pair[:key_name] = resource[:key_name] unless resource[:key_name].nil?
    end
    return symbolize(key_pair)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info("Calling operation delete_key_pair")
    client = Aws::EC2::Client.new(region: self.class.get_region)
    client.delete_key_pair({namevar => resource.provider.property_hash[namevar]})
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
