require 'json'
require 'retries'

require 'aws-sdk-rds'


Puppet::Type.type(:aws_db_cluster).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end

  # ProviderRDSDBCluster Properties
  def namevar
    :db_cluster_identifier
  end

  def self.namevar
    :db_cluster_identifier
  end


  def allocated_storage=(value)
    Puppet.info("allocated_storage setter called to change to #{value}")
    @property_flush[:allocated_storage] = value
  end

  def apply_immediately=(value)
    Puppet.info("apply_immediately setter called to change to #{value}")
    @property_flush[:apply_immediately] = value
  end

  def associated_roles=(value)
    Puppet.info("associated_roles setter called to change to #{value}")
    @property_flush[:associated_roles] = value
  end

  def availability_zones=(value)
    Puppet.info("availability_zones setter called to change to #{value}")
    @property_flush[:availability_zones] = value
  end

  def backtrack_consumed_change_records=(value)
    Puppet.info("backtrack_consumed_change_records setter called to change to #{value}")
    @property_flush[:backtrack_consumed_change_records] = value
  end

  def backtrack_window=(value)
    Puppet.info("backtrack_window setter called to change to #{value}")
    @property_flush[:backtrack_window] = value
  end

  def backup_retention_period=(value)
    Puppet.info("backup_retention_period setter called to change to #{value}")
    @property_flush[:backup_retention_period] = value
  end

  def capacity=(value)
    Puppet.info("capacity setter called to change to #{value}")
    @property_flush[:capacity] = value
  end

  def character_set_name=(value)
    Puppet.info("character_set_name setter called to change to #{value}")
    @property_flush[:character_set_name] = value
  end

  def clone_group_id=(value)
    Puppet.info("clone_group_id setter called to change to #{value}")
    @property_flush[:clone_group_id] = value
  end

  def cloudwatch_logs_export_configuration=(value)
    Puppet.info("cloudwatch_logs_export_configuration setter called to change to #{value}")
    @property_flush[:cloudwatch_logs_export_configuration] = value
  end

  def cluster_create_time=(value)
    Puppet.info("cluster_create_time setter called to change to #{value}")
    @property_flush[:cluster_create_time] = value
  end

  def custom_endpoints=(value)
    Puppet.info("custom_endpoints setter called to change to #{value}")
    @property_flush[:custom_endpoints] = value
  end

  def database_name=(value)
    Puppet.info("database_name setter called to change to #{value}")
    @property_flush[:database_name] = value
  end

  def db_cluster_arn=(value)
    Puppet.info("db_cluster_arn setter called to change to #{value}")
    @property_flush[:db_cluster_arn] = value
  end

  def db_cluster_identifier=(value)
    Puppet.info("db_cluster_identifier setter called to change to #{value}")
    @property_flush[:db_cluster_identifier] = value
  end

  def db_cluster_members=(value)
    Puppet.info("db_cluster_members setter called to change to #{value}")
    @property_flush[:db_cluster_members] = value
  end

  def db_cluster_option_group_memberships=(value)
    Puppet.info("db_cluster_option_group_memberships setter called to change to #{value}")
    @property_flush[:db_cluster_option_group_memberships] = value
  end

  def db_cluster_parameter_group=(value)
    Puppet.info("db_cluster_parameter_group setter called to change to #{value}")
    @property_flush[:db_cluster_parameter_group] = value
  end

  def db_cluster_parameter_group_name=(value)
    Puppet.info("db_cluster_parameter_group_name setter called to change to #{value}")
    @property_flush[:db_cluster_parameter_group_name] = value
  end

  def db_cluster_resource_id=(value)
    Puppet.info("db_cluster_resource_id setter called to change to #{value}")
    @property_flush[:db_cluster_resource_id] = value
  end

  def db_subnet_group=(value)
    Puppet.info("db_subnet_group setter called to change to #{value}")
    @property_flush[:db_subnet_group] = value
  end

  def db_subnet_group_name=(value)
    Puppet.info("db_subnet_group_name setter called to change to #{value}")
    @property_flush[:db_subnet_group_name] = value
  end

  def deletion_protection=(value)
    Puppet.info("deletion_protection setter called to change to #{value}")
    @property_flush[:deletion_protection] = value
  end

  def earliest_backtrack_time=(value)
    Puppet.info("earliest_backtrack_time setter called to change to #{value}")
    @property_flush[:earliest_backtrack_time] = value
  end

  def earliest_restorable_time=(value)
    Puppet.info("earliest_restorable_time setter called to change to #{value}")
    @property_flush[:earliest_restorable_time] = value
  end

  def enable_cloudwatch_logs_exports=(value)
    Puppet.info("enable_cloudwatch_logs_exports setter called to change to #{value}")
    @property_flush[:enable_cloudwatch_logs_exports] = value
  end

  def enabled_cloudwatch_logs_exports=(value)
    Puppet.info("enabled_cloudwatch_logs_exports setter called to change to #{value}")
    @property_flush[:enabled_cloudwatch_logs_exports] = value
  end

  def enable_http_endpoint=(value)
    Puppet.info("enable_http_endpoint setter called to change to #{value}")
    @property_flush[:enable_http_endpoint] = value
  end

  def enable_iam_database_authentication=(value)
    Puppet.info("enable_iam_database_authentication setter called to change to #{value}")
    @property_flush[:enable_iam_database_authentication] = value
  end

  def endpoint=(value)
    Puppet.info("endpoint setter called to change to #{value}")
    @property_flush[:endpoint] = value
  end

  def engine=(value)
    Puppet.info("engine setter called to change to #{value}")
    @property_flush[:engine] = value
  end

  def engine_mode=(value)
    Puppet.info("engine_mode setter called to change to #{value}")
    @property_flush[:engine_mode] = value
  end

  def engine_version=(value)
    Puppet.info("engine_version setter called to change to #{value}")
    @property_flush[:engine_version] = value
  end

  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end

  def final_db_snapshot_identifier=(value)
    Puppet.info("final_db_snapshot_identifier setter called to change to #{value}")
    @property_flush[:final_db_snapshot_identifier] = value
  end

  def global_cluster_identifier=(value)
    Puppet.info("global_cluster_identifier setter called to change to #{value}")
    @property_flush[:global_cluster_identifier] = value
  end

  def hosted_zone_id=(value)
    Puppet.info("hosted_zone_id setter called to change to #{value}")
    @property_flush[:hosted_zone_id] = value
  end

  def http_endpoint_enabled=(value)
    Puppet.info("http_endpoint_enabled setter called to change to #{value}")
    @property_flush[:http_endpoint_enabled] = value
  end

  def iam_database_authentication_enabled=(value)
    Puppet.info("iam_database_authentication_enabled setter called to change to #{value}")
    @property_flush[:iam_database_authentication_enabled] = value
  end

  def kms_key_id=(value)
    Puppet.info("kms_key_id setter called to change to #{value}")
    @property_flush[:kms_key_id] = value
  end

  def latest_restorable_time=(value)
    Puppet.info("latest_restorable_time setter called to change to #{value}")
    @property_flush[:latest_restorable_time] = value
  end

  def master_username=(value)
    Puppet.info("master_username setter called to change to #{value}")
    @property_flush[:master_username] = value
  end

  def master_user_password=(value)
    Puppet.info("master_user_password setter called to change to #{value}")
    @property_flush[:master_user_password] = value
  end

  def max_records=(value)
    Puppet.info("max_records setter called to change to #{value}")
    @property_flush[:max_records] = value
  end

  def multi_az=(value)
    Puppet.info("multi_az setter called to change to #{value}")
    @property_flush[:multi_az] = value
  end

  def new_db_cluster_identifier=(value)
    Puppet.info("new_db_cluster_identifier setter called to change to #{value}")
    @property_flush[:new_db_cluster_identifier] = value
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

  def preferred_backup_window=(value)
    Puppet.info("preferred_backup_window setter called to change to #{value}")
    @property_flush[:preferred_backup_window] = value
  end

  def preferred_maintenance_window=(value)
    Puppet.info("preferred_maintenance_window setter called to change to #{value}")
    @property_flush[:preferred_maintenance_window] = value
  end

  def pre_signed_url=(value)
    Puppet.info("pre_signed_url setter called to change to #{value}")
    @property_flush[:pre_signed_url] = value
  end

  def reader_endpoint=(value)
    Puppet.info("reader_endpoint setter called to change to #{value}")
    @property_flush[:reader_endpoint] = value
  end

  def read_replica_identifiers=(value)
    Puppet.info("read_replica_identifiers setter called to change to #{value}")
    @property_flush[:read_replica_identifiers] = value
  end

  def replication_source_identifier=(value)
    Puppet.info("replication_source_identifier setter called to change to #{value}")
    @property_flush[:replication_source_identifier] = value
  end

  def scaling_configuration=(value)
    Puppet.info("scaling_configuration setter called to change to #{value}")
    @property_flush[:scaling_configuration] = value
  end

  def scaling_configuration_info=(value)
    Puppet.info("scaling_configuration_info setter called to change to #{value}")
    @property_flush[:scaling_configuration_info] = value
  end

  def skip_final_snapshot=(value)
    Puppet.info("skip_final_snapshot setter called to change to #{value}")
    @property_flush[:skip_final_snapshot] = value
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

  def vpc_security_group_ids=(value)
    Puppet.info("vpc_security_group_ids setter called to change to #{value}")
    @property_flush[:vpc_security_group_ids] = value
  end

  def vpc_security_groups=(value)
    Puppet.info("vpc_security_groups setter called to change to #{value}")
    @property_flush[:vpc_security_groups] = value
  end


  def name=(value)
    Puppet.info("name setter called to change to #{value}")
    @property_flush[:name] = value
  end

  def self.region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def self.name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end

  attr_reader :property_hash

  def build_hash
    db_cluster = {}
    if @is_create || @is_update
      db_cluster[:apply_immediately] = resource[:apply_immediately] unless resource[:apply_immediately].nil?
      db_cluster[:availability_zones] = resource[:availability_zones] unless resource[:availability_zones].nil?
      db_cluster[:backtrack_window] = resource[:backtrack_window] unless resource[:backtrack_window].nil?
      db_cluster[:backup_retention_period] = resource[:backup_retention_period] unless resource[:backup_retention_period].nil?
      db_cluster[:character_set_name] = resource[:character_set_name] unless resource[:character_set_name].nil?
      db_cluster[:cloudwatch_logs_export_configuration] = resource[:cloudwatch_logs_export_configuration] unless resource[:cloudwatch_logs_export_configuration].nil?
      db_cluster[:database_name] = resource[:database_name] unless resource[:database_name].nil?
      db_cluster[:db_cluster_identifier] = resource[:db_cluster_identifier] unless resource[:db_cluster_identifier].nil?
      db_cluster[:db_cluster_parameter_group_name] = resource[:db_cluster_parameter_group_name] unless resource[:db_cluster_parameter_group_name].nil?
      db_cluster[:db_subnet_group_name] = resource[:db_subnet_group_name] unless resource[:db_subnet_group_name].nil?
      db_cluster[:deletion_protection] = resource[:deletion_protection] unless resource[:deletion_protection].nil?
      db_cluster[:enable_cloudwatch_logs_exports] = resource[:enable_cloudwatch_logs_exports] unless resource[:enable_cloudwatch_logs_exports].nil?
      db_cluster[:enable_http_endpoint] = resource[:enable_http_endpoint] unless resource[:enable_http_endpoint].nil?
      db_cluster[:enable_iam_database_authentication] = resource[:enable_iam_database_authentication] unless resource[:enable_iam_database_authentication].nil?
      db_cluster[:engine] = resource[:engine] unless resource[:engine].nil?
      db_cluster[:engine_mode] = resource[:engine_mode] unless resource[:engine_mode].nil?
      db_cluster[:engine_version] = resource[:engine_version] unless resource[:engine_version].nil?
      db_cluster[:filters] = resource[:filters] unless resource[:filters].nil?
      db_cluster[:final_db_snapshot_identifier] = resource[:final_db_snapshot_identifier] unless resource[:final_db_snapshot_identifier].nil?
      db_cluster[:global_cluster_identifier] = resource[:global_cluster_identifier] unless resource[:global_cluster_identifier].nil?
      db_cluster[:kms_key_id] = resource[:kms_key_id] unless resource[:kms_key_id].nil?
      db_cluster[:master_username] = resource[:master_username] unless resource[:master_username].nil?
      db_cluster[:master_user_password] = resource[:master_user_password] unless resource[:master_user_password].nil?
      db_cluster[:max_records] = resource[:max_records] unless resource[:max_records].nil?
      db_cluster[:database_name] = resource[:database_name] unless resource[:database_name].nil?
      db_cluster[:new_db_cluster_identifier] = resource[:new_db_cluster_identifier] unless resource[:new_db_cluster_identifier].nil?
      db_cluster[:option_group_name] = resource[:option_group_name] unless resource[:option_group_name].nil?
      db_cluster[:port] = resource[:port] unless resource[:port].nil?
      db_cluster[:preferred_backup_window] = resource[:preferred_backup_window] unless resource[:preferred_backup_window].nil?
      db_cluster[:preferred_maintenance_window] = resource[:preferred_maintenance_window] unless resource[:preferred_maintenance_window].nil?
      db_cluster[:pre_signed_url] = resource[:pre_signed_url] unless resource[:pre_signed_url].nil?
      db_cluster[:replication_source_identifier] = resource[:replication_source_identifier] unless resource[:replication_source_identifier].nil?
      db_cluster[:scaling_configuration] = resource[:scaling_configuration] unless resource[:scaling_configuration].nil?
      db_cluster[:storage_encrypted] = resource[:storage_encrypted] unless resource[:storage_encrypted].nil?
      db_cluster[:tags] = resource[:tags] unless resource[:tags].nil?
      db_cluster[:vpc_security_group_ids] = resource[:vpc_security_group_ids] unless resource[:vpc_security_group_ids].nil?
    else
      db_cluster[:skip_final_snapshot] = resource['skip_final_snapshot'] unless resource['skip_final_snapshot'].nil?
      db_cluster[:final_db_snapshot_identifier] = resource['final_db_snapshot_identifier'] unless resource['final_db_snapshot_identifier'].nil?
    end
    db_cluster[namevar] = resource[:name]
    symbolize(db_cluster)
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::RDS::Client.new(region: self.class.region)
    client.create_db_cluster(build_hash)
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
    Puppet.info('Calling operation delete_db_cluster')
    client = Aws::RDS::Client.new(region: self.class.region)
    client.delete_db_cluster(build_hash)
    @property_hash[:ensure] = :absent
  end

  def exists?
    Puppet.info("Parametered Describe for resource #{name} of type <no value>")
    client = Aws::RDS::Client.new(region: self.class.region)
    response = client.describe_db_clusters(namevar => name)
    @property_hash[:object] = response
    return true
  rescue StandardError
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
