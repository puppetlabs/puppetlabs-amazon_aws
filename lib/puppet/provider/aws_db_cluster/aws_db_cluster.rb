require 'puppet/resource_api'


require 'aws-sdk-rds'






# AwsDbCluster class
class Puppet::Provider::AwsDbCluster::AwsDbCluster
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client        = Aws::RDS::Client.new(region: region)
    all_instances = []
    client.describe_db_clusters.each do |list|
      list.db_clusters.each do |l|
        client.describe_db_clusters(namevar => l[:db_cluster_identifier]).each do |response|
          response.db_clusters.each do |i|
            hash = instance_to_hash(i)
            all_instances << hash if name?(hash)
          end
        end
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances


  end

  def instance_to_hash(instance)
    allocated_storage = instance.respond_to?(:allocated_storage) ? (instance.allocated_storage.respond_to?(:to_hash) ? instance.allocated_storage.to_hash : instance.allocated_storage) : nil
    apply_immediately = instance.respond_to?(:apply_immediately) ? (instance.apply_immediately.respond_to?(:to_hash) ? instance.apply_immediately.to_hash : instance.apply_immediately) : nil
    associated_roles = instance.respond_to?(:associated_roles) ? (instance.associated_roles.respond_to?(:to_hash) ? instance.associated_roles.to_hash : instance.associated_roles) : nil
    availability_zones = instance.respond_to?(:availability_zones) ? (instance.availability_zones.respond_to?(:to_hash) ? instance.availability_zones.to_hash : instance.availability_zones) : nil
    backtrack_consumed_change_records = instance.respond_to?(:backtrack_consumed_change_records) ? (instance.backtrack_consumed_change_records.respond_to?(:to_hash) ? instance.backtrack_consumed_change_records.to_hash : instance.backtrack_consumed_change_records) : nil
    backtrack_window = instance.respond_to?(:backtrack_window) ? (instance.backtrack_window.respond_to?(:to_hash) ? instance.backtrack_window.to_hash : instance.backtrack_window) : nil
    backup_retention_period = instance.respond_to?(:backup_retention_period) ? (instance.backup_retention_period.respond_to?(:to_hash) ? instance.backup_retention_period.to_hash : instance.backup_retention_period) : nil
    capacity = instance.respond_to?(:capacity) ? (instance.capacity.respond_to?(:to_hash) ? instance.capacity.to_hash : instance.capacity) : nil
    character_set_name = instance.respond_to?(:character_set_name) ? (instance.character_set_name.respond_to?(:to_hash) ? instance.character_set_name.to_hash : instance.character_set_name) : nil
    clone_group_id = instance.respond_to?(:clone_group_id) ? (instance.clone_group_id.respond_to?(:to_hash) ? instance.clone_group_id.to_hash : instance.clone_group_id) : nil
    cloudwatch_logs_export_configuration = instance.respond_to?(:cloudwatch_logs_export_configuration) ? (instance.cloudwatch_logs_export_configuration.respond_to?(:to_hash) ? instance.cloudwatch_logs_export_configuration.to_hash : instance.cloudwatch_logs_export_configuration) : nil
    cluster_create_time = instance.respond_to?(:cluster_create_time) ? (instance.cluster_create_time.respond_to?(:to_hash) ? instance.cluster_create_time.to_hash : instance.cluster_create_time) : nil
    copy_tags_to_snapshot = instance.respond_to?(:copy_tags_to_snapshot) ? (instance.copy_tags_to_snapshot.respond_to?(:to_hash) ? instance.copy_tags_to_snapshot.to_hash : instance.copy_tags_to_snapshot) : nil
    custom_endpoints = instance.respond_to?(:custom_endpoints) ? (instance.custom_endpoints.respond_to?(:to_hash) ? instance.custom_endpoints.to_hash : instance.custom_endpoints) : nil
    database_name = instance.respond_to?(:database_name) ? (instance.database_name.respond_to?(:to_hash) ? instance.database_name.to_hash : instance.database_name) : nil
    db_cluster_arn = instance.respond_to?(:db_cluster_arn) ? (instance.db_cluster_arn.respond_to?(:to_hash) ? instance.db_cluster_arn.to_hash : instance.db_cluster_arn) : nil
    db_cluster_identifier = instance.respond_to?(:db_cluster_identifier) ? (instance.db_cluster_identifier.respond_to?(:to_hash) ? instance.db_cluster_identifier.to_hash : instance.db_cluster_identifier) : nil
    db_cluster_members = instance.respond_to?(:db_cluster_members) ? (instance.db_cluster_members.respond_to?(:to_hash) ? instance.db_cluster_members.to_hash : instance.db_cluster_members) : nil
    db_cluster_option_group_memberships = instance.respond_to?(:db_cluster_option_group_memberships) ? (instance.db_cluster_option_group_memberships.respond_to?(:to_hash) ? instance.db_cluster_option_group_memberships.to_hash : instance.db_cluster_option_group_memberships) : nil
    db_cluster_parameter_group = instance.respond_to?(:db_cluster_parameter_group) ? (instance.db_cluster_parameter_group.respond_to?(:to_hash) ? instance.db_cluster_parameter_group.to_hash : instance.db_cluster_parameter_group) : nil
    db_cluster_parameter_group_name = instance.respond_to?(:db_cluster_parameter_group_name) ? (instance.db_cluster_parameter_group_name.respond_to?(:to_hash) ? instance.db_cluster_parameter_group_name.to_hash : instance.db_cluster_parameter_group_name) : nil
    db_cluster_resource_id = instance.respond_to?(:db_cluster_resource_id) ? (instance.db_cluster_resource_id.respond_to?(:to_hash) ? instance.db_cluster_resource_id.to_hash : instance.db_cluster_resource_id) : nil
    db_subnet_group = instance.respond_to?(:db_subnet_group) ? (instance.db_subnet_group.respond_to?(:to_hash) ? instance.db_subnet_group.to_hash : instance.db_subnet_group) : nil
    db_subnet_group_name = instance.respond_to?(:db_subnet_group_name) ? (instance.db_subnet_group_name.respond_to?(:to_hash) ? instance.db_subnet_group_name.to_hash : instance.db_subnet_group_name) : nil
    deletion_protection = instance.respond_to?(:deletion_protection) ? (instance.deletion_protection.respond_to?(:to_hash) ? instance.deletion_protection.to_hash : instance.deletion_protection) : nil
    earliest_backtrack_time = instance.respond_to?(:earliest_backtrack_time) ? (instance.earliest_backtrack_time.respond_to?(:to_hash) ? instance.earliest_backtrack_time.to_hash : instance.earliest_backtrack_time) : nil
    earliest_restorable_time = instance.respond_to?(:earliest_restorable_time) ? (instance.earliest_restorable_time.respond_to?(:to_hash) ? instance.earliest_restorable_time.to_hash : instance.earliest_restorable_time) : nil
    enable_cloudwatch_logs_exports = instance.respond_to?(:enable_cloudwatch_logs_exports) ? (instance.enable_cloudwatch_logs_exports.respond_to?(:to_hash) ? instance.enable_cloudwatch_logs_exports.to_hash : instance.enable_cloudwatch_logs_exports) : nil
    enabled_cloudwatch_logs_exports = instance.respond_to?(:enabled_cloudwatch_logs_exports) ? (instance.enabled_cloudwatch_logs_exports.respond_to?(:to_hash) ? instance.enabled_cloudwatch_logs_exports.to_hash : instance.enabled_cloudwatch_logs_exports) : nil
    enable_http_endpoint = instance.respond_to?(:enable_http_endpoint) ? (instance.enable_http_endpoint.respond_to?(:to_hash) ? instance.enable_http_endpoint.to_hash : instance.enable_http_endpoint) : nil
    enable_iam_database_authentication = instance.respond_to?(:enable_iam_database_authentication) ? (instance.enable_iam_database_authentication.respond_to?(:to_hash) ? instance.enable_iam_database_authentication.to_hash : instance.enable_iam_database_authentication) : nil
    endpoint = instance.respond_to?(:endpoint) ? (instance.endpoint.respond_to?(:to_hash) ? instance.endpoint.to_hash : instance.endpoint) : nil
    engine = instance.respond_to?(:engine) ? (instance.engine.respond_to?(:to_hash) ? instance.engine.to_hash : instance.engine) : nil
    engine_mode = instance.respond_to?(:engine_mode) ? (instance.engine_mode.respond_to?(:to_hash) ? instance.engine_mode.to_hash : instance.engine_mode) : nil
    engine_version = instance.respond_to?(:engine_version) ? (instance.engine_version.respond_to?(:to_hash) ? instance.engine_version.to_hash : instance.engine_version) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    final_db_snapshot_identifier = instance.respond_to?(:final_db_snapshot_identifier) ? (instance.final_db_snapshot_identifier.respond_to?(:to_hash) ? instance.final_db_snapshot_identifier.to_hash : instance.final_db_snapshot_identifier) : nil
    global_cluster_identifier = instance.respond_to?(:global_cluster_identifier) ? (instance.global_cluster_identifier.respond_to?(:to_hash) ? instance.global_cluster_identifier.to_hash : instance.global_cluster_identifier) : nil
    hosted_zone_id = instance.respond_to?(:hosted_zone_id) ? (instance.hosted_zone_id.respond_to?(:to_hash) ? instance.hosted_zone_id.to_hash : instance.hosted_zone_id) : nil
    http_endpoint_enabled = instance.respond_to?(:http_endpoint_enabled) ? (instance.http_endpoint_enabled.respond_to?(:to_hash) ? instance.http_endpoint_enabled.to_hash : instance.http_endpoint_enabled) : nil
    iam_database_authentication_enabled = instance.respond_to?(:iam_database_authentication_enabled) ? (instance.iam_database_authentication_enabled.respond_to?(:to_hash) ? instance.iam_database_authentication_enabled.to_hash : instance.iam_database_authentication_enabled) : nil
    kms_key_id = instance.respond_to?(:kms_key_id) ? (instance.kms_key_id.respond_to?(:to_hash) ? instance.kms_key_id.to_hash : instance.kms_key_id) : nil
    latest_restorable_time = instance.respond_to?(:latest_restorable_time) ? (instance.latest_restorable_time.respond_to?(:to_hash) ? instance.latest_restorable_time.to_hash : instance.latest_restorable_time) : nil
    master_username = instance.respond_to?(:master_username) ? (instance.master_username.respond_to?(:to_hash) ? instance.master_username.to_hash : instance.master_username) : nil
    master_user_password = instance.respond_to?(:master_user_password) ? (instance.master_user_password.respond_to?(:to_hash) ? instance.master_user_password.to_hash : instance.master_user_password) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records) : nil
    multi_az = instance.respond_to?(:multi_az) ? (instance.multi_az.respond_to?(:to_hash) ? instance.multi_az.to_hash : instance.multi_az) : nil
    new_db_cluster_identifier = instance.respond_to?(:new_db_cluster_identifier) ? (instance.new_db_cluster_identifier.respond_to?(:to_hash) ? instance.new_db_cluster_identifier.to_hash : instance.new_db_cluster_identifier) : nil
    option_group_name = instance.respond_to?(:option_group_name) ? (instance.option_group_name.respond_to?(:to_hash) ? instance.option_group_name.to_hash : instance.option_group_name) : nil
    percent_progress = instance.respond_to?(:percent_progress) ? (instance.percent_progress.respond_to?(:to_hash) ? instance.percent_progress.to_hash : instance.percent_progress) : nil
    port = instance.respond_to?(:port) ? (instance.port.respond_to?(:to_hash) ? instance.port.to_hash : instance.port) : nil
    preferred_backup_window = instance.respond_to?(:preferred_backup_window) ? (instance.preferred_backup_window.respond_to?(:to_hash) ? instance.preferred_backup_window.to_hash : instance.preferred_backup_window) : nil
    preferred_maintenance_window = instance.respond_to?(:preferred_maintenance_window) ? (instance.preferred_maintenance_window.respond_to?(:to_hash) ? instance.preferred_maintenance_window.to_hash : instance.preferred_maintenance_window) : nil
    pre_signed_url = instance.respond_to?(:pre_signed_url) ? (instance.pre_signed_url.respond_to?(:to_hash) ? instance.pre_signed_url.to_hash : instance.pre_signed_url) : nil
    reader_endpoint = instance.respond_to?(:reader_endpoint) ? (instance.reader_endpoint.respond_to?(:to_hash) ? instance.reader_endpoint.to_hash : instance.reader_endpoint) : nil
    read_replica_identifiers = instance.respond_to?(:read_replica_identifiers) ? (instance.read_replica_identifiers.respond_to?(:to_hash) ? instance.read_replica_identifiers.to_hash : instance.read_replica_identifiers) : nil
    replication_source_identifier = instance.respond_to?(:replication_source_identifier) ? (instance.replication_source_identifier.respond_to?(:to_hash) ? instance.replication_source_identifier.to_hash : instance.replication_source_identifier) : nil
    scaling_configuration = instance.respond_to?(:scaling_configuration) ? (instance.scaling_configuration.respond_to?(:to_hash) ? instance.scaling_configuration.to_hash : instance.scaling_configuration) : nil
    scaling_configuration_info = instance.respond_to?(:scaling_configuration_info) ? (instance.scaling_configuration_info.respond_to?(:to_hash) ? instance.scaling_configuration_info.to_hash : instance.scaling_configuration_info) : nil
    skip_final_snapshot = instance.respond_to?(:skip_final_snapshot) ? (instance.skip_final_snapshot.respond_to?(:to_hash) ? instance.skip_final_snapshot.to_hash : instance.skip_final_snapshot) : nil
    status = instance.respond_to?(:status) ? (instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status) : nil
    storage_encrypted = instance.respond_to?(:storage_encrypted) ? (instance.storage_encrypted.respond_to?(:to_hash) ? instance.storage_encrypted.to_hash : instance.storage_encrypted) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    vpc_security_group_ids = instance.respond_to?(:vpc_security_group_ids) ? (instance.vpc_security_group_ids.respond_to?(:to_hash) ? instance.vpc_security_group_ids.to_hash : instance.vpc_security_group_ids) : nil
    vpc_security_groups = instance.respond_to?(:vpc_security_groups) ? (instance.vpc_security_groups.respond_to?(:to_hash) ? instance.vpc_security_groups.to_hash : instance.vpc_security_groups) : nil

    db_cluster = {}
    db_cluster[:ensure] = :present
    db_cluster[:object] = instance
    db_cluster[:name] = instance.to_hash[self.namevar]
      db_cluster[:allocated_storage] = allocated_storage unless allocated_storage.nil?
      db_cluster[:apply_immediately] = apply_immediately unless apply_immediately.nil?
      db_cluster[:associated_roles] = associated_roles unless associated_roles.nil?
      db_cluster[:availability_zones] = availability_zones unless availability_zones.nil?
      db_cluster[:backtrack_consumed_change_records] = backtrack_consumed_change_records unless backtrack_consumed_change_records.nil?
      db_cluster[:backtrack_window] = backtrack_window unless backtrack_window.nil?
      db_cluster[:backup_retention_period] = backup_retention_period unless backup_retention_period.nil?
      db_cluster[:capacity] = capacity unless capacity.nil?
      db_cluster[:character_set_name] = character_set_name unless character_set_name.nil?
      db_cluster[:clone_group_id] = clone_group_id unless clone_group_id.nil?
      db_cluster[:cloudwatch_logs_export_configuration] = cloudwatch_logs_export_configuration unless cloudwatch_logs_export_configuration.nil?
      db_cluster[:cluster_create_time] = cluster_create_time unless cluster_create_time.nil?
      db_cluster[:copy_tags_to_snapshot] = copy_tags_to_snapshot unless copy_tags_to_snapshot.nil?
      db_cluster[:custom_endpoints] = custom_endpoints unless custom_endpoints.nil?
      db_cluster[:database_name] = database_name unless database_name.nil?
      db_cluster[:db_cluster_arn] = db_cluster_arn unless db_cluster_arn.nil?
      db_cluster[:db_cluster_identifier] = db_cluster_identifier unless db_cluster_identifier.nil?
      db_cluster[:db_cluster_members] = db_cluster_members unless db_cluster_members.nil?
      db_cluster[:db_cluster_option_group_memberships] = db_cluster_option_group_memberships unless db_cluster_option_group_memberships.nil?
      db_cluster[:db_cluster_parameter_group] = db_cluster_parameter_group unless db_cluster_parameter_group.nil?
      db_cluster[:db_cluster_parameter_group_name] = db_cluster_parameter_group_name unless db_cluster_parameter_group_name.nil?
      db_cluster[:db_cluster_resource_id] = db_cluster_resource_id unless db_cluster_resource_id.nil?
      db_cluster[:db_subnet_group] = db_subnet_group unless db_subnet_group.nil?
      db_cluster[:db_subnet_group_name] = db_subnet_group_name unless db_subnet_group_name.nil?
      db_cluster[:deletion_protection] = deletion_protection unless deletion_protection.nil?
      db_cluster[:earliest_backtrack_time] = earliest_backtrack_time unless earliest_backtrack_time.nil?
      db_cluster[:earliest_restorable_time] = earliest_restorable_time unless earliest_restorable_time.nil?
      db_cluster[:enable_cloudwatch_logs_exports] = enable_cloudwatch_logs_exports unless enable_cloudwatch_logs_exports.nil?
      db_cluster[:enabled_cloudwatch_logs_exports] = enabled_cloudwatch_logs_exports unless enabled_cloudwatch_logs_exports.nil?
      db_cluster[:enable_http_endpoint] = enable_http_endpoint unless enable_http_endpoint.nil?
      db_cluster[:enable_iam_database_authentication] = enable_iam_database_authentication unless enable_iam_database_authentication.nil?
      db_cluster[:endpoint] = endpoint unless endpoint.nil?
      db_cluster[:engine] = engine unless engine.nil?
      db_cluster[:engine_mode] = engine_mode unless engine_mode.nil?
      db_cluster[:engine_version] = engine_version unless engine_version.nil?
      db_cluster[:filters] = filters unless filters.nil?
      db_cluster[:final_db_snapshot_identifier] = final_db_snapshot_identifier unless final_db_snapshot_identifier.nil?
      db_cluster[:global_cluster_identifier] = global_cluster_identifier unless global_cluster_identifier.nil?
      db_cluster[:hosted_zone_id] = hosted_zone_id unless hosted_zone_id.nil?
      db_cluster[:http_endpoint_enabled] = http_endpoint_enabled unless http_endpoint_enabled.nil?
      db_cluster[:iam_database_authentication_enabled] = iam_database_authentication_enabled unless iam_database_authentication_enabled.nil?
      db_cluster[:kms_key_id] = kms_key_id unless kms_key_id.nil?
      db_cluster[:latest_restorable_time] = latest_restorable_time unless latest_restorable_time.nil?
      db_cluster[:master_username] = master_username unless master_username.nil?
      db_cluster[:master_user_password] = master_user_password unless master_user_password.nil?
      db_cluster[:max_records] = max_records unless max_records.nil?
      db_cluster[:multi_az] = multi_az unless multi_az.nil?
      db_cluster[:new_db_cluster_identifier] = new_db_cluster_identifier unless new_db_cluster_identifier.nil?
      db_cluster[:option_group_name] = option_group_name unless option_group_name.nil?
      db_cluster[:percent_progress] = percent_progress unless percent_progress.nil?
      db_cluster[:port] = port unless port.nil?
      db_cluster[:preferred_backup_window] = preferred_backup_window unless preferred_backup_window.nil?
      db_cluster[:preferred_maintenance_window] = preferred_maintenance_window unless preferred_maintenance_window.nil?
      db_cluster[:pre_signed_url] = pre_signed_url unless pre_signed_url.nil?
      db_cluster[:reader_endpoint] = reader_endpoint unless reader_endpoint.nil?
      db_cluster[:read_replica_identifiers] = read_replica_identifiers unless read_replica_identifiers.nil?
      db_cluster[:replication_source_identifier] = replication_source_identifier unless replication_source_identifier.nil?
      db_cluster[:scaling_configuration] = scaling_configuration unless scaling_configuration.nil?
      db_cluster[:scaling_configuration_info] = scaling_configuration_info unless scaling_configuration_info.nil?
      db_cluster[:skip_final_snapshot] = skip_final_snapshot unless skip_final_snapshot.nil?
      db_cluster[:status] = status unless status.nil?
      db_cluster[:storage_encrypted] = storage_encrypted unless storage_encrypted.nil?
      db_cluster[:tags] = tags unless tags.nil?
      db_cluster[:vpc_security_group_ids] = vpc_security_group_ids unless vpc_security_group_ids.nil?
      db_cluster[:vpc_security_groups] = vpc_security_groups unless vpc_security_groups.nil?
    db_cluster
  end

  def namevar
    :db_cluster_identifier
  end

  def self.namevar
    :db_cluster_identifier
  end

  def name?(hash)
    !hash[self.namevar].nil? && !hash[self.namevar].empty?
  end

  def set(context, changes, noop: false)
    context.debug('Entered set')

    changes.each do |name, change|
      context.debug("set change with #{name} and #{change}")
      is = change.key?(:is) ? change[:is] : get(context).find { |key| key[:id] == name }
      should = change[:should]

      is = { name: name, ensure: 'absent' } if is.nil?
      should = { name: name, ensure: 'absent' } if should.nil?

      if is[:ensure].to_s == 'absent' && should[:ensure].to_s == 'present'
        create(context, name, should) unless noop
      elsif is[:ensure].to_s == 'present' && should[:ensure].to_s == 'absent'
        context.deleting(name) do
          delete(should) unless noop
        end
      elsif is[:ensure].to_s == 'absent' && should[:ensure].to_s == 'absent'
        context.failed(name, message: 'Unexpected absent to absent change')
      elsif is[:ensure].to_s == 'present' && should[:ensure].to_s == 'present'
        # if update method exists call update, else delete and recreate the resourceupdate(context, name, should)
      end
    end
  end

  def self.region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def create(context, name, should)
    context.creating(name) do
      new_hash = symbolize(build_hash(should))

      client   = Aws::RDS::Client.new(region: region)
      client.create_db_cluster(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))

      client = Aws::RDS::Client.new(region: region)
      client.modify_db_cluster(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    db_cluster = {}
          db_cluster[:apply_immediately] = resource[:apply_immediately] unless resource[:apply_immediately].nil?
          db_cluster[:availability_zones] = resource[:availability_zones] unless resource[:availability_zones].nil?
          db_cluster[:backtrack_window] = resource[:backtrack_window] unless resource[:backtrack_window].nil?
          db_cluster[:backup_retention_period] = resource[:backup_retention_period] unless resource[:backup_retention_period].nil?
          db_cluster[:character_set_name] = resource[:character_set_name] unless resource[:character_set_name].nil?
          db_cluster[:cloudwatch_logs_export_configuration] = resource[:cloudwatch_logs_export_configuration] unless resource[:cloudwatch_logs_export_configuration].nil?
          db_cluster[:copy_tags_to_snapshot] = resource[:copy_tags_to_snapshot] unless resource[:copy_tags_to_snapshot].nil?
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
          db_cluster[:option_group_name] = resource[:option_group_name] unless resource[:option_group_name].nil?
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
    db_cluster[namevar] = resource[:name]
    symbolize(db_cluster)
  end

  def build_hash_delete(resource)
    db_cluster = {}
        db_cluster[:apply_immediately] = resource[:apply_immediately] unless resource[:apply_immediately].nil?
        db_cluster[:availability_zones] = resource[:availability_zones] unless resource[:availability_zones].nil?
        db_cluster[:backtrack_window] = resource[:backtrack_window] unless resource[:backtrack_window].nil?
        db_cluster[:backup_retention_period] = resource[:backup_retention_period] unless resource[:backup_retention_period].nil?
        db_cluster[:character_set_name] = resource[:character_set_name] unless resource[:character_set_name].nil?
        db_cluster[:cloudwatch_logs_export_configuration] = resource[:cloudwatch_logs_export_configuration] unless resource[:cloudwatch_logs_export_configuration].nil?
        db_cluster[:copy_tags_to_snapshot] = resource[:copy_tags_to_snapshot] unless resource[:copy_tags_to_snapshot].nil?
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
        db_cluster[:option_group_name] = resource[:option_group_name] unless resource[:option_group_name].nil?
        db_cluster[:new_db_cluster_identifier] = resource[:new_db_cluster_identifier] unless resource[:new_db_cluster_identifier].nil?
        db_cluster[:option_group_name] = resource[:option_group_name] unless resource[:option_group_name].nil?
        db_cluster[:port] = resource[:port] unless resource[:port].nil?
        db_cluster[:preferred_backup_window] = resource[:preferred_backup_window] unless resource[:preferred_backup_window].nil?
        db_cluster[:preferred_maintenance_window] = resource[:preferred_maintenance_window] unless resource[:preferred_maintenance_window].nil?
        db_cluster[:pre_signed_url] = resource[:pre_signed_url] unless resource[:pre_signed_url].nil?
        db_cluster[:replication_source_identifier] = resource[:replication_source_identifier] unless resource[:replication_source_identifier].nil?
        db_cluster[:scaling_configuration] = resource[:scaling_configuration] unless resource[:scaling_configuration].nil?
        db_cluster[:skip_final_snapshot] = resource[:skip_final_snapshot] unless resource[:skip_final_snapshot].nil?
        db_cluster[:storage_encrypted] = resource[:storage_encrypted] unless resource[:storage_encrypted].nil?
        db_cluster[:tags] = resource[:tags] unless resource[:tags].nil?
        db_cluster[:vpc_security_group_ids] = resource[:vpc_security_group_ids] unless resource[:vpc_security_group_ids].nil?
    db_cluster[namevar] = resource[:name]
    symbolize(db_cluster)
  end

  def self.build_key_values
    key_values = {}
    key_values
  end

  def destroy
    delete(resource)
  end

  def delete(should)
    new_hash = symbolize(build_hash_delete(should))
    client = Aws::RDS::Client.new(region: region)
    client.delete_db_cluster(new_hash)
  rescue StandardError => ex
    Puppet.alert("Exception during destroy. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
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
