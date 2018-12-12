require 'json'
require 'retries'

require 'aws-sdk-rds'


Puppet::Type.type(:aws_db_cluster_snapshot).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end

  # RDS Properties
  def namevar
    :db_cluster_snapshot_identifier
  end

  def self.namevar
    :db_cluster_snapshot_identifier
  end


  def allocated_storage=(value)
    Puppet.info("allocated_storage setter called to change to #{value}")
    @property_flush[:allocated_storage] = value
  end

  def availability_zones=(value)
    Puppet.info("availability_zones setter called to change to #{value}")
    @property_flush[:availability_zones] = value
  end

  def cluster_create_time=(value)
    Puppet.info("cluster_create_time setter called to change to #{value}")
    @property_flush[:cluster_create_time] = value
  end

  def db_cluster_identifier=(value)
    Puppet.info("db_cluster_identifier setter called to change to #{value}")
    @property_flush[:db_cluster_identifier] = value
  end

  def db_cluster_snapshot_arn=(value)
    Puppet.info("db_cluster_snapshot_arn setter called to change to #{value}")
    @property_flush[:db_cluster_snapshot_arn] = value
  end

  def db_cluster_snapshot_identifier=(value)
    Puppet.info("db_cluster_snapshot_identifier setter called to change to #{value}")
    @property_flush[:db_cluster_snapshot_identifier] = value
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

  def percent_progress=(value)
    Puppet.info("percent_progress setter called to change to #{value}")
    @property_flush[:percent_progress] = value
  end

  def port=(value)
    Puppet.info("port setter called to change to #{value}")
    @property_flush[:port] = value
  end

  def snapshot_create_time=(value)
    Puppet.info("snapshot_create_time setter called to change to #{value}")
    @property_flush[:snapshot_create_time] = value
  end

  def snapshot_type=(value)
    Puppet.info("snapshot_type setter called to change to #{value}")
    @property_flush[:snapshot_type] = value
  end

  def source_db_cluster_snapshot_arn=(value)
    Puppet.info("source_db_cluster_snapshot_arn setter called to change to #{value}")
    @property_flush[:source_db_cluster_snapshot_arn] = value
  end

  def status=(value)
    Puppet.info("status setter called to change to #{value}")
    @property_flush[:status] = value
  end

  def storage_encrypted=(value)
    Puppet.info("storage_encrypted setter called to change to #{value}")
    @property_flush[:storage_encrypted] = value
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

  attr_reader :property_hash

  def self.region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def self.name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end
  def self.instances
    Puppet.debug("Calling instances for region #{region}")
    client = Aws::RDS::Client.new(region: region)

    all_instances = []
    client.describe_db_cluster_snapshots.each do |response|
      response.db_cluster_snapshots.each do |i|
        hash = instance_to_hash(i)
        all_instances << new(hash) if name?(hash)
      end
    end
    all_instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      name = prov.property_hash[namevar]
      if (resource = (resources.find { |k, _| k.casecmp(name).zero? } || [])[1])
        resource.provider = prov
      end
    end
  end

  def self.instance_to_hash(instance)
    allocated_storage = instance.respond_to?(:allocated_storage) ? (instance.allocated_storage.respond_to?(:to_hash) ? instance.allocated_storage.to_hash : instance.allocated_storage) : nil
    availability_zones = instance.respond_to?(:availability_zones) ? (instance.availability_zones.respond_to?(:to_hash) ? instance.availability_zones.to_hash : instance.availability_zones) : nil
    cluster_create_time = instance.respond_to?(:cluster_create_time) ? (instance.cluster_create_time.respond_to?(:to_hash) ? instance.cluster_create_time.to_hash : instance.cluster_create_time) : nil
    db_cluster_identifier = instance.respond_to?(:db_cluster_identifier) ? (instance.db_cluster_identifier.respond_to?(:to_hash) ? instance.db_cluster_identifier.to_hash : instance.db_cluster_identifier) : nil
    db_cluster_snapshot_arn = instance.respond_to?(:db_cluster_snapshot_arn) ? (instance.db_cluster_snapshot_arn.respond_to?(:to_hash) ? instance.db_cluster_snapshot_arn.to_hash : instance.db_cluster_snapshot_arn) : nil
    db_cluster_snapshot_identifier = instance.respond_to?(:db_cluster_snapshot_identifier) ? (instance.db_cluster_snapshot_identifier.respond_to?(:to_hash) ? instance.db_cluster_snapshot_identifier.to_hash : instance.db_cluster_snapshot_identifier) : nil
    engine = instance.respond_to?(:engine) ? (instance.engine.respond_to?(:to_hash) ? instance.engine.to_hash : instance.engine) : nil
    engine_version = instance.respond_to?(:engine_version) ? (instance.engine_version.respond_to?(:to_hash) ? instance.engine_version.to_hash : instance.engine_version) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    iam_database_authentication_enabled = instance.respond_to?(:iam_database_authentication_enabled) ? (instance.iam_database_authentication_enabled.respond_to?(:to_hash) ? instance.iam_database_authentication_enabled.to_hash : instance.iam_database_authentication_enabled) : nil
    include_public = instance.respond_to?(:include_public) ? (instance.include_public.respond_to?(:to_hash) ? instance.include_public.to_hash : instance.include_public) : nil
    include_shared = instance.respond_to?(:include_shared) ? (instance.include_shared.respond_to?(:to_hash) ? instance.include_shared.to_hash : instance.include_shared) : nil
    kms_key_id = instance.respond_to?(:kms_key_id) ? (instance.kms_key_id.respond_to?(:to_hash) ? instance.kms_key_id.to_hash : instance.kms_key_id) : nil
    license_model = instance.respond_to?(:license_model) ? (instance.license_model.respond_to?(:to_hash) ? instance.license_model.to_hash : instance.license_model) : nil
    master_username = instance.respond_to?(:master_username) ? (instance.master_username.respond_to?(:to_hash) ? instance.master_username.to_hash : instance.master_username) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records) : nil
    percent_progress = instance.respond_to?(:percent_progress) ? (instance.percent_progress.respond_to?(:to_hash) ? instance.percent_progress.to_hash : instance.percent_progress) : nil
    port = instance.respond_to?(:port) ? (instance.port.respond_to?(:to_hash) ? instance.port.to_hash : instance.port) : nil
    snapshot_create_time = instance.respond_to?(:snapshot_create_time) ? (instance.snapshot_create_time.respond_to?(:to_hash) ? instance.snapshot_create_time.to_hash : instance.snapshot_create_time) : nil
    snapshot_type = instance.respond_to?(:snapshot_type) ? (instance.snapshot_type.respond_to?(:to_hash) ? instance.snapshot_type.to_hash : instance.snapshot_type) : nil
    source_db_cluster_snapshot_arn = instance.respond_to?(:source_db_cluster_snapshot_arn) ? (instance.source_db_cluster_snapshot_arn.respond_to?(:to_hash) ? instance.source_db_cluster_snapshot_arn.to_hash : instance.source_db_cluster_snapshot_arn) : nil
    status = instance.respond_to?(:status) ? (instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status) : nil
    storage_encrypted = instance.respond_to?(:storage_encrypted) ? (instance.storage_encrypted.respond_to?(:to_hash) ? instance.storage_encrypted.to_hash : instance.storage_encrypted) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    db_cluster_snapshot = {}
    db_cluster_snapshot[:ensure] = :present
    db_cluster_snapshot[:object] = instance
    db_cluster_snapshot[:name] = instance.to_hash[namevar]

    db_cluster_snapshot[:allocated_storage] = allocated_storage unless allocated_storage.nil?
    db_cluster_snapshot[:availability_zones] = availability_zones unless availability_zones.nil?
    db_cluster_snapshot[:cluster_create_time] = cluster_create_time unless cluster_create_time.nil?
    db_cluster_snapshot[:db_cluster_identifier] = db_cluster_identifier unless db_cluster_identifier.nil?
    db_cluster_snapshot[:db_cluster_snapshot_arn] = db_cluster_snapshot_arn unless db_cluster_snapshot_arn.nil?
    db_cluster_snapshot[:db_cluster_snapshot_identifier] = db_cluster_snapshot_identifier unless db_cluster_snapshot_identifier.nil?
    db_cluster_snapshot[:engine] = engine unless engine.nil?
    db_cluster_snapshot[:engine_version] = engine_version unless engine_version.nil?
    db_cluster_snapshot[:filters] = filters unless filters.nil?
    db_cluster_snapshot[:iam_database_authentication_enabled] = iam_database_authentication_enabled unless iam_database_authentication_enabled.nil?
    db_cluster_snapshot[:include_public] = include_public unless include_public.nil?
    db_cluster_snapshot[:include_shared] = include_shared unless include_shared.nil?
    db_cluster_snapshot[:kms_key_id] = kms_key_id unless kms_key_id.nil?
    db_cluster_snapshot[:license_model] = license_model unless license_model.nil?
    db_cluster_snapshot[:master_username] = master_username unless master_username.nil?
    db_cluster_snapshot[:max_records] = max_records unless max_records.nil?
    db_cluster_snapshot[:percent_progress] = percent_progress unless percent_progress.nil?
    db_cluster_snapshot[:port] = port unless port.nil?
    db_cluster_snapshot[:snapshot_create_time] = snapshot_create_time unless snapshot_create_time.nil?
    db_cluster_snapshot[:snapshot_type] = snapshot_type unless snapshot_type.nil?
    db_cluster_snapshot[:source_db_cluster_snapshot_arn] = source_db_cluster_snapshot_arn unless source_db_cluster_snapshot_arn.nil?
    db_cluster_snapshot[:status] = status unless status.nil?
    db_cluster_snapshot[:storage_encrypted] = storage_encrypted unless storage_encrypted.nil?
    db_cluster_snapshot[:tags] = tags unless tags.nil?
    db_cluster_snapshot[:vpc_id] = vpc_id unless vpc_id.nil?
    db_cluster_snapshot
  end

  def build_hash
    db_cluster_snapshot = {}
    if @is_create || @is_update
      db_cluster_snapshot[:db_cluster_identifier] = resource[:db_cluster_identifier] unless resource[:db_cluster_identifier].nil?
      db_cluster_snapshot[:db_cluster_snapshot_identifier] = resource[:db_cluster_snapshot_identifier] unless resource[:db_cluster_snapshot_identifier].nil?
      db_cluster_snapshot[:filters] = resource[:filters] unless resource[:filters].nil?
      db_cluster_snapshot[:include_public] = resource[:include_public] unless resource[:include_public].nil?
      db_cluster_snapshot[:include_shared] = resource[:include_shared] unless resource[:include_shared].nil?
      db_cluster_snapshot[:max_records] = resource[:max_records] unless resource[:max_records].nil?
      db_cluster_snapshot[:snapshot_type] = resource[:snapshot_type] unless resource[:snapshot_type].nil?
      db_cluster_snapshot[:tags] = resource[:tags] unless resource[:tags].nil?
    end
    db_cluster_snapshot[namevar] = resource[:name]
    symbolize(db_cluster_snapshot)
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::RDS::Client.new(region: self.class.region)
    client.create_db_cluster_snapshot(build_hash)
    @property_hash[:ensure] = :present
  rescue StandardError => ex
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
    []
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info('Calling operation delete_db_cluster_snapshot')
    client = Aws::RDS::Client.new(region: self.class.region)
    client.delete_db_cluster_snapshot(build_hash)
    @property_hash[:ensure] = :absent
  end


  # Shared funcs
  def exists?
    return_value = @property_hash[:ensure] && @property_hash[:ensure] != :absent
    Puppet.info("Checking if resource #{name} of type <no value> exists, returning #{return_value}")
    return_value
  end

  attr_reader :property_hash


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
