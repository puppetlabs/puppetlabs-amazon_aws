require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-ec2"


Puppet::Type.type(:aws_route_table).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  def namevar
    :route_table_id
  end

  # Properties

  def associations=(value)
    Puppet.info("associations setter called to change to #{value}")
    @property_flush[:associations] = value
  end

  def dry_run=(value)
    Puppet.info("dry_run setter called to change to #{value}")
    @property_flush[:dry_run] = value
  end

  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end

  def max_results=(value)
    Puppet.info("max_results setter called to change to #{value}")
    @property_flush[:max_results] = value
  end

  def next_token=(value)
    Puppet.info("next_token setter called to change to #{value}")
    @property_flush[:next_token] = value
  end

  def propagating_vgws=(value)
    Puppet.info("propagating_vgws setter called to change to #{value}")
    @property_flush[:propagating_vgws] = value
  end

  def routes=(value)
    Puppet.info("routes setter called to change to #{value}")
    @property_flush[:routes] = value
  end

  def route_table_id=(value)
    Puppet.info("route_table_id setter called to change to #{value}")
    @property_flush[:route_table_id] = value
  end

  def route_table_ids=(value)
    Puppet.info("route_table_ids setter called to change to #{value}")
    @property_flush[:route_table_ids] = value
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

  def self.get_region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def self.has_name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end
  def self.instances
    Puppet.debug("Calling instances for region #{self.get_region}")
    client = Aws::EC2::Client.new(region: self.get_region)

    all_instances = []
    client.describe_route_tables.each do |response|
      response.route_tables.each do |i|
        hash = instance_to_hash(i)
        all_instances << new(hash) if has_name?(hash)
      end
    end
    all_instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      tags = prov.respond_to?(:tags) ? prov.tags : nil
      tags = prov.respond_to?(:tag_set) ? prov.tag_set : tags
      if tags 
        name = tags.find { |x| x[:key] == "Name" }[:value]
        if (resource = (resources.find { |k, v| k.casecmp(name).zero? } || [])[1])
          resource.provider = prov
        end
      end
    end
  end

  def self.name_from_tag(instance)
    tags = instance.respond_to?(:tags) ? instance.tags : nil
    tags = instance.respond_to?(:tag_set) ? instance.tag_set : tags
    name = tags.find { |x| x.key == 'Name' } unless tags.nil?
    name.value unless name.nil?
  end

  def self.instance_to_hash(instance)
    associations = instance.respond_to?(:associations) ? (instance.associations.respond_to?(:to_hash) ? instance.associations.to_hash : instance.associations ) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    max_results = instance.respond_to?(:max_results) ? (instance.max_results.respond_to?(:to_hash) ? instance.max_results.to_hash : instance.max_results ) : nil
    next_token = instance.respond_to?(:next_token) ? (instance.next_token.respond_to?(:to_hash) ? instance.next_token.to_hash : instance.next_token ) : nil
    propagating_vgws = instance.respond_to?(:propagating_vgws) ? (instance.propagating_vgws.respond_to?(:to_hash) ? instance.propagating_vgws.to_hash : instance.propagating_vgws ) : nil
    routes = instance.respond_to?(:routes) ? (instance.routes.respond_to?(:to_hash) ? instance.routes.to_hash : instance.routes ) : nil
    route_table_id = instance.respond_to?(:route_table_id) ? (instance.route_table_id.respond_to?(:to_hash) ? instance.route_table_id.to_hash : instance.route_table_id ) : nil
    route_table_ids = instance.respond_to?(:route_table_ids) ? (instance.route_table_ids.respond_to?(:to_hash) ? instance.route_table_ids.to_hash : instance.route_table_ids ) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags ) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id ) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) and instance.tags.size > 0
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) and instance.tag_set.size > 0

    hash[:associations] = associations unless associations.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:max_results] = max_results unless max_results.nil?
    hash[:next_token] = next_token unless next_token.nil?
    hash[:propagating_vgws] = propagating_vgws unless propagating_vgws.nil?
    hash[:routes] = routes unless routes.nil?
    hash[:route_table_id] = route_table_id unless route_table_id.nil?
    hash[:route_table_ids] = route_table_ids unless route_table_ids.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:vpc_id] = vpc_id unless vpc_id.nil?
    hash
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EC2::Client.new(region: self.class.get_region)
    response = client.create_route_table(build_hash)
    res = response.respond_to?(:route_table) ? response.route_table : response
    with_retries(:max_tries => 5) do  
      client.create_tags(
        resources: [res.to_hash[namevar]],
        tags: [{ key: 'Name', value: resource.provider.name}]
      )
    end
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
    route_table = {}
    if @is_create || @is_update
      route_table[:dry_run] = resource[:dry_run] unless resource[:dry_run].nil?
      route_table[:filters] = resource[:filters] unless resource[:filters].nil?
      route_table[:vpc_id] = resource[:vpc_id] unless resource[:vpc_id].nil?
      route_table[:max_results] = resource[:max_results] unless resource[:max_results].nil?
      route_table[:next_token] = resource[:next_token] unless resource[:next_token].nil?
      route_table[:route_table_id] = resource[:route_table_id] unless resource[:route_table_id].nil?
      route_table[:route_table_ids] = resource[:route_table_ids] unless resource[:route_table_ids].nil?
      route_table[:vpc_id] = resource[:vpc_id] unless resource[:vpc_id].nil?
    end
    return symbolize(route_table)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info("Calling operation delete_route_table")
    client = Aws::EC2::Client.new(region: self.class.get_region)
    client.delete_route_table({namevar => resource.provider.property_hash[namevar]})
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
