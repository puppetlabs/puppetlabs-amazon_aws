require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-rds"


Puppet::Type.type(:aws_db_snapshot).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  # RDS Properties
  
  def namevar
    :db_snapshot_identifier
  end

  def self.namevar
    :db_snapshot_identifier
  end
  
  
  def allocated_storage=(value)
    Puppet.info("allocated_storage setter called to change to #{value}")
    @property_flush[:allocated_storage] = value
  end
    
  
  def availability_zone=(value)
    Puppet.info("availability_zone setter called to change to #{value}")
    @property_flush[:availability_zone] = value
  end
    
  
  def db_instance_identifier=(value)
    Puppet.info("db_instance_identifier setter called to change to #{value}")
    @property_flush[:db_instance_identifier] = value
  end
    
  
  def db_snapshot_arn=(value)
    Puppet.info("db_snapshot_arn setter called to change to #{value}")
    @property_flush[:db_snapshot_arn] = value
  end
    
  
  def db_snapshot_identifier=(value)
    Puppet.info("db_snapshot_identifier setter called to change to #{value}")
    @property_flush[:db_snapshot_identifier] = value
  end
    
  
  def encrypted=(value)
    Puppet.info("encrypted setter called to change to #{value}")
    @property_flush[:encrypted] = value
  end
    
  
  def engine=(value)
    Puppet.info("engine setter called to change to #{value}")
    @property_flush[:engine] = value
  end
    
  
  def engine_version=(value)
    Puppet.info("engine_version setter called to change to #{value}")
    @property_flush[:engine_version] = value
  end
    
  
  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end
    
  
  def iam_database_authentication_enabled=(value)
    Puppet.info("iam_database_authentication_enabled setter called to change to #{value}")
    @property_flush[:iam_database_authentication_enabled] = value
  end
    
  
  def include_public=(value)
    Puppet.info("include_public setter called to change to #{value}")
    @property_flush[:include_public] = value
  end
    
  
  def include_shared=(value)
    Puppet.info("include_shared setter called to change to #{value}")
    @property_flush[:include_shared] = value
  end
    
  
  def instance_create_time=(value)
    Puppet.info("instance_create_time setter called to change to #{value}")
    @property_flush[:instance_create_time] = value
  end
    
  
  def iops=(value)
    Puppet.info("iops setter called to change to #{value}")
    @property_flush[:iops] = value
  end
    
  
  def kms_key_id=(value)
    Puppet.info("kms_key_id setter called to change to #{value}")
    @property_flush[:kms_key_id] = value
  end
    
  
  def license_model=(value)
    Puppet.info("license_model setter called to change to #{value}")
    @property_flush[:license_model] = value
  end
    
  
  def master_username=(value)
    Puppet.info("master_username setter called to change to #{value}")
    @property_flush[:master_username] = value
  end
    
  
  def max_records=(value)
    Puppet.info("max_records setter called to change to #{value}")
    @property_flush[:max_records] = value
  end
    
  
  def option_group_name=(value)
    Puppet.info("option_group_name setter called to change to #{value}")
    @property_flush[:option_group_name] = value
  end
    
  
  def percent_progress=(value)
    Puppet.info("percent_progress setter called to change to #{value}")
    @property_flush[:percent_progress] = value
  end
    
  
  def port=(value)
    Puppet.info("port setter called to change to #{value}")
    @property_flush[:port] = value
  end
    
  
  def processor_features=(value)
    Puppet.info("processor_features setter called to change to #{value}")
    @property_flush[:processor_features] = value
  end
    
  
  def snapshot_create_time=(value)
    Puppet.info("snapshot_create_time setter called to change to #{value}")
    @property_flush[:snapshot_create_time] = value
  end
    
  
  def snapshot_type=(value)
    Puppet.info("snapshot_type setter called to change to #{value}")
    @property_flush[:snapshot_type] = value
  end
    
  
  def source_db_snapshot_identifier=(value)
    Puppet.info("source_db_snapshot_identifier setter called to change to #{value}")
    @property_flush[:source_db_snapshot_identifier] = value
  end
    
  
  def source_region=(value)
    Puppet.info("source_region setter called to change to #{value}")
    @property_flush[:source_region] = value
  end
    
  
  def status=(value)
    Puppet.info("status setter called to change to #{value}")
    @property_flush[:status] = value
  end
    
  
  def storage_type=(value)
    Puppet.info("storage_type setter called to change to #{value}")
    @property_flush[:storage_type] = value
  end
    
  
  def tags=(value)
    Puppet.info("tags setter called to change to #{value}")
    @property_flush[:tags] = value
  end
    
  
  def tde_credential_arn=(value)
    Puppet.info("tde_credential_arn setter called to change to #{value}")
    @property_flush[:tde_credential_arn] = value
  end
    
  
  def timezone=(value)
    Puppet.info("timezone setter called to change to #{value}")
    @property_flush[:timezone] = value
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
    client.describe_db_snapshots.each do |response|
      response.db_snapshots.each do |i|
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
  
    allocated_storage = instance.respond_to?(:allocated_storage) ? (instance.allocated_storage.respond_to?(:to_hash) ? instance.allocated_storage.to_hash : instance.allocated_storage ) : nil
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone ) : nil
    db_instance_identifier = instance.respond_to?(:db_instance_identifier) ? (instance.db_instance_identifier.respond_to?(:to_hash) ? instance.db_instance_identifier.to_hash : instance.db_instance_identifier ) : nil
    db_snapshot_arn = instance.respond_to?(:db_snapshot_arn) ? (instance.db_snapshot_arn.respond_to?(:to_hash) ? instance.db_snapshot_arn.to_hash : instance.db_snapshot_arn ) : nil
    db_snapshot_identifier = instance.respond_to?(:db_snapshot_identifier) ? (instance.db_snapshot_identifier.respond_to?(:to_hash) ? instance.db_snapshot_identifier.to_hash : instance.db_snapshot_identifier ) : nil
    encrypted = instance.respond_to?(:encrypted) ? (instance.encrypted.respond_to?(:to_hash) ? instance.encrypted.to_hash : instance.encrypted ) : nil
    engine = instance.respond_to?(:engine) ? (instance.engine.respond_to?(:to_hash) ? instance.engine.to_hash : instance.engine ) : nil
    engine_version = instance.respond_to?(:engine_version) ? (instance.engine_version.respond_to?(:to_hash) ? instance.engine_version.to_hash : instance.engine_version ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    iam_database_authentication_enabled = instance.respond_to?(:iam_database_authentication_enabled) ? (instance.iam_database_authentication_enabled.respond_to?(:to_hash) ? instance.iam_database_authentication_enabled.to_hash : instance.iam_database_authentication_enabled ) : nil
    include_public = instance.respond_to?(:include_public) ? (instance.include_public.respond_to?(:to_hash) ? instance.include_public.to_hash : instance.include_public ) : nil
    include_shared = instance.respond_to?(:include_shared) ? (instance.include_shared.respond_to?(:to_hash) ? instance.include_shared.to_hash : instance.include_shared ) : nil
    instance_create_time = instance.respond_to?(:instance_create_time) ? (instance.instance_create_time.respond_to?(:to_hash) ? instance.instance_create_time.to_hash : instance.instance_create_time ) : nil
    iops = instance.respond_to?(:iops) ? (instance.iops.respond_to?(:to_hash) ? instance.iops.to_hash : instance.iops ) : nil
    kms_key_id = instance.respond_to?(:kms_key_id) ? (instance.kms_key_id.respond_to?(:to_hash) ? instance.kms_key_id.to_hash : instance.kms_key_id ) : nil
    license_model = instance.respond_to?(:license_model) ? (instance.license_model.respond_to?(:to_hash) ? instance.license_model.to_hash : instance.license_model ) : nil
    master_username = instance.respond_to?(:master_username) ? (instance.master_username.respond_to?(:to_hash) ? instance.master_username.to_hash : instance.master_username ) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records ) : nil
    option_group_name = instance.respond_to?(:option_group_name) ? (instance.option_group_name.respond_to?(:to_hash) ? instance.option_group_name.to_hash : instance.option_group_name ) : nil
    percent_progress = instance.respond_to?(:percent_progress) ? (instance.percent_progress.respond_to?(:to_hash) ? instance.percent_progress.to_hash : instance.percent_progress ) : nil
    port = instance.respond_to?(:port) ? (instance.port.respond_to?(:to_hash) ? instance.port.to_hash : instance.port ) : nil
    processor_features = instance.respond_to?(:processor_features) ? (instance.processor_features.respond_to?(:to_hash) ? instance.processor_features.to_hash : instance.processor_features ) : nil
    snapshot_create_time = instance.respond_to?(:snapshot_create_time) ? (instance.snapshot_create_time.respond_to?(:to_hash) ? instance.snapshot_create_time.to_hash : instance.snapshot_create_time ) : nil
    snapshot_type = instance.respond_to?(:snapshot_type) ? (instance.snapshot_type.respond_to?(:to_hash) ? instance.snapshot_type.to_hash : instance.snapshot_type ) : nil
    source_db_snapshot_identifier = instance.respond_to?(:source_db_snapshot_identifier) ? (instance.source_db_snapshot_identifier.respond_to?(:to_hash) ? instance.source_db_snapshot_identifier.to_hash : instance.source_db_snapshot_identifier ) : nil
    source_region = instance.respond_to?(:source_region) ? (instance.source_region.respond_to?(:to_hash) ? instance.source_region.to_hash : instance.source_region ) : nil
    status = instance.respond_to?(:status) ? (instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status ) : nil
    storage_type = instance.respond_to?(:storage_type) ? (instance.storage_type.respond_to?(:to_hash) ? instance.storage_type.to_hash : instance.storage_type ) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags ) : nil
    tde_credential_arn = instance.respond_to?(:tde_credential_arn) ? (instance.tde_credential_arn.respond_to?(:to_hash) ? instance.tde_credential_arn.to_hash : instance.tde_credential_arn ) : nil
    timezone = instance.respond_to?(:timezone) ? (instance.timezone.respond_to?(:to_hash) ? instance.timezone.to_hash : instance.timezone ) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id ) : nil

    db_snapshot = {}
    db_snapshot[:ensure] = :present
    db_snapshot[:object] = instance
    db_snapshot[:name] = instance.to_hash[self.namevar]
  
    db_snapshot[:allocated_storage] = allocated_storage unless allocated_storage.nil?
    db_snapshot[:availability_zone] = availability_zone unless availability_zone.nil?
    db_snapshot[:db_instance_identifier] = db_instance_identifier unless db_instance_identifier.nil?
    db_snapshot[:db_snapshot_arn] = db_snapshot_arn unless db_snapshot_arn.nil?
    db_snapshot[:db_snapshot_identifier] = db_snapshot_identifier unless db_snapshot_identifier.nil?
    db_snapshot[:encrypted] = encrypted unless encrypted.nil?
    db_snapshot[:engine] = engine unless engine.nil?
    db_snapshot[:engine_version] = engine_version unless engine_version.nil?
    db_snapshot[:filters] = filters unless filters.nil?
    db_snapshot[:iam_database_authentication_enabled] = iam_database_authentication_enabled unless iam_database_authentication_enabled.nil?
    db_snapshot[:include_public] = include_public unless include_public.nil?
    db_snapshot[:include_shared] = include_shared unless include_shared.nil?
    db_snapshot[:instance_create_time] = instance_create_time unless instance_create_time.nil?
    db_snapshot[:iops] = iops unless iops.nil?
    db_snapshot[:kms_key_id] = kms_key_id unless kms_key_id.nil?
    db_snapshot[:license_model] = license_model unless license_model.nil?
    db_snapshot[:master_username] = master_username unless master_username.nil?
    db_snapshot[:max_records] = max_records unless max_records.nil?
    db_snapshot[:option_group_name] = option_group_name unless option_group_name.nil?
    db_snapshot[:percent_progress] = percent_progress unless percent_progress.nil?
    db_snapshot[:port] = port unless port.nil?
    db_snapshot[:processor_features] = processor_features unless processor_features.nil?
    db_snapshot[:snapshot_create_time] = snapshot_create_time unless snapshot_create_time.nil?
    db_snapshot[:snapshot_type] = snapshot_type unless snapshot_type.nil?
    db_snapshot[:source_db_snapshot_identifier] = source_db_snapshot_identifier unless source_db_snapshot_identifier.nil?
    db_snapshot[:source_region] = source_region unless source_region.nil?
    db_snapshot[:status] = status unless status.nil?
    db_snapshot[:storage_type] = storage_type unless storage_type.nil?
    db_snapshot[:tags] = tags unless tags.nil?
    db_snapshot[:tde_credential_arn] = tde_credential_arn unless tde_credential_arn.nil?
    db_snapshot[:timezone] = timezone unless timezone.nil?
    db_snapshot[:vpc_id] = vpc_id unless vpc_id.nil?
    db_snapshot
  end

  def build_hash
    db_snapshot = {}
    if @is_create || @is_update
      db_snapshot[:db_instance_identifier] = resource[:db_instance_identifier] unless resource[:db_instance_identifier].nil?
      db_snapshot[:db_snapshot_identifier] = resource[:db_snapshot_identifier] unless resource[:db_snapshot_identifier].nil?
      db_snapshot[:engine_version] = resource[:engine_version] unless resource[:engine_version].nil?
      db_snapshot[:filters] = resource[:filters] unless resource[:filters].nil?
      db_snapshot[:include_public] = resource[:include_public] unless resource[:include_public].nil?
      db_snapshot[:include_shared] = resource[:include_shared] unless resource[:include_shared].nil?
      db_snapshot[:max_records] = resource[:max_records] unless resource[:max_records].nil?
      db_snapshot[:option_group_name] = resource[:option_group_name] unless resource[:option_group_name].nil?
      db_snapshot[:option_group_name] = resource[:option_group_name] unless resource[:option_group_name].nil?
      db_snapshot[:snapshot_type] = resource[:snapshot_type] unless resource[:snapshot_type].nil?
      db_snapshot[:tags] = resource[:tags] unless resource[:tags].nil?
    end
    db_snapshot[self.namevar] = resource[:name]
    return symbolize(db_snapshot)
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    response = client.create_db_snapshot(build_hash)
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
    Puppet.info("Calling operation delete_db_snapshot")
    client = Aws::RDS::Client.new(region: self.class.get_region)
    client.delete_db_snapshot(build_hash)
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
