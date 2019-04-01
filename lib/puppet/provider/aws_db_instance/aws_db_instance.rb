require 'puppet/resource_api'


require 'aws-sdk-rds'






# AwsDbInstance class
class Puppet::Provider::AwsDbInstance::AwsDbInstance
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client        = Aws::RDS::Client.new(region: region)
    all_instances = []
    client.describe_db_instances.each do |list|
      list.db_instances.each do |l|
        client.describe_db_instances(namevar => l[:db_instance_identifier]).each do |response|
          response.db_instances.each do |i|
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
    allow_major_version_upgrade = instance.respond_to?(:allow_major_version_upgrade) ? (instance.allow_major_version_upgrade.respond_to?(:to_hash) ? instance.allow_major_version_upgrade.to_hash : instance.allow_major_version_upgrade) : nil
    apply_immediately = instance.respond_to?(:apply_immediately) ? (instance.apply_immediately.respond_to?(:to_hash) ? instance.apply_immediately.to_hash : instance.apply_immediately) : nil
    associated_roles = instance.respond_to?(:associated_roles) ? (instance.associated_roles.respond_to?(:to_hash) ? instance.associated_roles.to_hash : instance.associated_roles) : nil
    auto_minor_version_upgrade = instance.respond_to?(:auto_minor_version_upgrade) ? (instance.auto_minor_version_upgrade.respond_to?(:to_hash) ? instance.auto_minor_version_upgrade.to_hash : instance.auto_minor_version_upgrade) : nil
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone) : nil
    backup_retention_period = instance.respond_to?(:backup_retention_period) ? (instance.backup_retention_period.respond_to?(:to_hash) ? instance.backup_retention_period.to_hash : instance.backup_retention_period) : nil
    ca_certificate_identifier = instance.respond_to?(:ca_certificate_identifier) ? (instance.ca_certificate_identifier.respond_to?(:to_hash) ? instance.ca_certificate_identifier.to_hash : instance.ca_certificate_identifier) : nil
    character_set_name = instance.respond_to?(:character_set_name) ? (instance.character_set_name.respond_to?(:to_hash) ? instance.character_set_name.to_hash : instance.character_set_name) : nil
    cloudwatch_logs_export_configuration = instance.respond_to?(:cloudwatch_logs_export_configuration) ? (instance.cloudwatch_logs_export_configuration.respond_to?(:to_hash) ? instance.cloudwatch_logs_export_configuration.to_hash : instance.cloudwatch_logs_export_configuration) : nil
    copy_tags_to_snapshot = instance.respond_to?(:copy_tags_to_snapshot) ? (instance.copy_tags_to_snapshot.respond_to?(:to_hash) ? instance.copy_tags_to_snapshot.to_hash : instance.copy_tags_to_snapshot) : nil
    db_cluster_identifier = instance.respond_to?(:db_cluster_identifier) ? (instance.db_cluster_identifier.respond_to?(:to_hash) ? instance.db_cluster_identifier.to_hash : instance.db_cluster_identifier) : nil
    db_instance_arn = instance.respond_to?(:db_instance_arn) ? (instance.db_instance_arn.respond_to?(:to_hash) ? instance.db_instance_arn.to_hash : instance.db_instance_arn) : nil
    db_instance_class = instance.respond_to?(:db_instance_class) ? (instance.db_instance_class.respond_to?(:to_hash) ? instance.db_instance_class.to_hash : instance.db_instance_class) : nil
    db_instance_identifier = instance.respond_to?(:db_instance_identifier) ? (instance.db_instance_identifier.respond_to?(:to_hash) ? instance.db_instance_identifier.to_hash : instance.db_instance_identifier) : nil
    db_instance_port = instance.respond_to?(:db_instance_port) ? (instance.db_instance_port.respond_to?(:to_hash) ? instance.db_instance_port.to_hash : instance.db_instance_port) : nil
    db_instance_status = instance.respond_to?(:db_instance_status) ? (instance.db_instance_status.respond_to?(:to_hash) ? instance.db_instance_status.to_hash : instance.db_instance_status) : nil
    dbi_resource_id = instance.respond_to?(:dbi_resource_id) ? (instance.dbi_resource_id.respond_to?(:to_hash) ? instance.dbi_resource_id.to_hash : instance.dbi_resource_id) : nil
    db_name = instance.respond_to?(:db_name) ? (instance.db_name.respond_to?(:to_hash) ? instance.db_name.to_hash : instance.db_name) : nil
    db_parameter_group_name = instance.respond_to?(:db_parameter_group_name) ? (instance.db_parameter_group_name.respond_to?(:to_hash) ? instance.db_parameter_group_name.to_hash : instance.db_parameter_group_name) : nil
    db_parameter_groups = instance.respond_to?(:db_parameter_groups) ? (instance.db_parameter_groups.respond_to?(:to_hash) ? instance.db_parameter_groups.to_hash : instance.db_parameter_groups) : nil
    db_port_number = instance.respond_to?(:db_port_number) ? (instance.db_port_number.respond_to?(:to_hash) ? instance.db_port_number.to_hash : instance.db_port_number) : nil
    db_security_groups = instance.respond_to?(:db_security_groups) ? (instance.db_security_groups.respond_to?(:to_hash) ? instance.db_security_groups.to_hash : instance.db_security_groups) : nil
    db_subnet_group = instance.respond_to?(:db_subnet_group) ? (instance.db_subnet_group.respond_to?(:to_hash) ? instance.db_subnet_group.to_hash : instance.db_subnet_group) : nil
    db_subnet_group_name = instance.respond_to?(:db_subnet_group_name) ? (instance.db_subnet_group_name.respond_to?(:to_hash) ? instance.db_subnet_group_name.to_hash : instance.db_subnet_group_name) : nil
    delete_automated_backups = instance.respond_to?(:delete_automated_backups) ? (instance.delete_automated_backups.respond_to?(:to_hash) ? instance.delete_automated_backups.to_hash : instance.delete_automated_backups) : nil
    deletion_protection = instance.respond_to?(:deletion_protection) ? (instance.deletion_protection.respond_to?(:to_hash) ? instance.deletion_protection.to_hash : instance.deletion_protection) : nil
    domain = instance.respond_to?(:domain) ? (instance.domain.respond_to?(:to_hash) ? instance.domain.to_hash : instance.domain) : nil
    domain_iam_role_name = instance.respond_to?(:domain_iam_role_name) ? (instance.domain_iam_role_name.respond_to?(:to_hash) ? instance.domain_iam_role_name.to_hash : instance.domain_iam_role_name) : nil
    domain_memberships = instance.respond_to?(:domain_memberships) ? (instance.domain_memberships.respond_to?(:to_hash) ? instance.domain_memberships.to_hash : instance.domain_memberships) : nil
    enable_cloudwatch_logs_exports = instance.respond_to?(:enable_cloudwatch_logs_exports) ? (instance.enable_cloudwatch_logs_exports.respond_to?(:to_hash) ? instance.enable_cloudwatch_logs_exports.to_hash : instance.enable_cloudwatch_logs_exports) : nil
    enabled_cloudwatch_logs_exports = instance.respond_to?(:enabled_cloudwatch_logs_exports) ? (instance.enabled_cloudwatch_logs_exports.respond_to?(:to_hash) ? instance.enabled_cloudwatch_logs_exports.to_hash : instance.enabled_cloudwatch_logs_exports) : nil
    enable_iam_database_authentication = instance.respond_to?(:enable_iam_database_authentication) ? (instance.enable_iam_database_authentication.respond_to?(:to_hash) ? instance.enable_iam_database_authentication.to_hash : instance.enable_iam_database_authentication) : nil
    enable_performance_insights = instance.respond_to?(:enable_performance_insights) ? (instance.enable_performance_insights.respond_to?(:to_hash) ? instance.enable_performance_insights.to_hash : instance.enable_performance_insights) : nil
    endpoint = instance.respond_to?(:endpoint) ? (instance.endpoint.respond_to?(:to_hash) ? instance.endpoint.to_hash : instance.endpoint) : nil
    engine = instance.respond_to?(:engine) ? (instance.engine.respond_to?(:to_hash) ? instance.engine.to_hash : instance.engine) : nil
    engine_version = instance.respond_to?(:engine_version) ? (instance.engine_version.respond_to?(:to_hash) ? instance.engine_version.to_hash : instance.engine_version) : nil
    enhanced_monitoring_resource_arn = instance.respond_to?(:enhanced_monitoring_resource_arn) ? (instance.enhanced_monitoring_resource_arn.respond_to?(:to_hash) ? instance.enhanced_monitoring_resource_arn.to_hash : instance.enhanced_monitoring_resource_arn) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    final_db_snapshot_identifier = instance.respond_to?(:final_db_snapshot_identifier) ? (instance.final_db_snapshot_identifier.respond_to?(:to_hash) ? instance.final_db_snapshot_identifier.to_hash : instance.final_db_snapshot_identifier) : nil
    iam_database_authentication_enabled = instance.respond_to?(:iam_database_authentication_enabled) ? (instance.iam_database_authentication_enabled.respond_to?(:to_hash) ? instance.iam_database_authentication_enabled.to_hash : instance.iam_database_authentication_enabled) : nil
    instance_create_time = instance.respond_to?(:instance_create_time) ? (instance.instance_create_time.respond_to?(:to_hash) ? instance.instance_create_time.to_hash : instance.instance_create_time) : nil
    iops = instance.respond_to?(:iops) ? (instance.iops.respond_to?(:to_hash) ? instance.iops.to_hash : instance.iops) : nil
    kms_key_id = instance.respond_to?(:kms_key_id) ? (instance.kms_key_id.respond_to?(:to_hash) ? instance.kms_key_id.to_hash : instance.kms_key_id) : nil
    latest_restorable_time = instance.respond_to?(:latest_restorable_time) ? (instance.latest_restorable_time.respond_to?(:to_hash) ? instance.latest_restorable_time.to_hash : instance.latest_restorable_time) : nil
    license_model = instance.respond_to?(:license_model) ? (instance.license_model.respond_to?(:to_hash) ? instance.license_model.to_hash : instance.license_model) : nil
    listener_endpoint = instance.respond_to?(:listener_endpoint) ? (instance.listener_endpoint.respond_to?(:to_hash) ? instance.listener_endpoint.to_hash : instance.listener_endpoint) : nil
    master_username = instance.respond_to?(:master_username) ? (instance.master_username.respond_to?(:to_hash) ? instance.master_username.to_hash : instance.master_username) : nil
    master_user_password = instance.respond_to?(:master_user_password) ? (instance.master_user_password.respond_to?(:to_hash) ? instance.master_user_password.to_hash : instance.master_user_password) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records) : nil
    monitoring_interval = instance.respond_to?(:monitoring_interval) ? (instance.monitoring_interval.respond_to?(:to_hash) ? instance.monitoring_interval.to_hash : instance.monitoring_interval) : nil
    monitoring_role_arn = instance.respond_to?(:monitoring_role_arn) ? (instance.monitoring_role_arn.respond_to?(:to_hash) ? instance.monitoring_role_arn.to_hash : instance.monitoring_role_arn) : nil
    multi_az = instance.respond_to?(:multi_az) ? (instance.multi_az.respond_to?(:to_hash) ? instance.multi_az.to_hash : instance.multi_az) : nil
    new_db_instance_identifier = instance.respond_to?(:new_db_instance_identifier) ? (instance.new_db_instance_identifier.respond_to?(:to_hash) ? instance.new_db_instance_identifier.to_hash : instance.new_db_instance_identifier) : nil
    option_group_memberships = instance.respond_to?(:option_group_memberships) ? (instance.option_group_memberships.respond_to?(:to_hash) ? instance.option_group_memberships.to_hash : instance.option_group_memberships) : nil
    option_group_name = instance.respond_to?(:option_group_name) ? (instance.option_group_name.respond_to?(:to_hash) ? instance.option_group_name.to_hash : instance.option_group_name) : nil
    pending_modified_values = instance.respond_to?(:pending_modified_values) ? (instance.pending_modified_values.respond_to?(:to_hash) ? instance.pending_modified_values.to_hash : instance.pending_modified_values) : nil
    performance_insights_enabled = instance.respond_to?(:performance_insights_enabled) ? (instance.performance_insights_enabled.respond_to?(:to_hash) ? instance.performance_insights_enabled.to_hash : instance.performance_insights_enabled) : nil
    performance_insights_kms_key_id = instance.respond_to?(:performance_insights_kms_key_id) ? (instance.performance_insights_kms_key_id.respond_to?(:to_hash) ? instance.performance_insights_kms_key_id.to_hash : instance.performance_insights_kms_key_id) : nil
    performance_insights_retention_period = instance.respond_to?(:performance_insights_retention_period) ? (instance.performance_insights_retention_period.respond_to?(:to_hash) ? instance.performance_insights_retention_period.to_hash : instance.performance_insights_retention_period) : nil
    port = instance.respond_to?(:port) ? (instance.port.respond_to?(:to_hash) ? instance.port.to_hash : instance.port) : nil
    preferred_backup_window = instance.respond_to?(:preferred_backup_window) ? (instance.preferred_backup_window.respond_to?(:to_hash) ? instance.preferred_backup_window.to_hash : instance.preferred_backup_window) : nil
    preferred_maintenance_window = instance.respond_to?(:preferred_maintenance_window) ? (instance.preferred_maintenance_window.respond_to?(:to_hash) ? instance.preferred_maintenance_window.to_hash : instance.preferred_maintenance_window) : nil
    processor_features = instance.respond_to?(:processor_features) ? (instance.processor_features.respond_to?(:to_hash) ? instance.processor_features.to_hash : instance.processor_features) : nil
    promotion_tier = instance.respond_to?(:promotion_tier) ? (instance.promotion_tier.respond_to?(:to_hash) ? instance.promotion_tier.to_hash : instance.promotion_tier) : nil
    publicly_accessible = instance.respond_to?(:publicly_accessible) ? (instance.publicly_accessible.respond_to?(:to_hash) ? instance.publicly_accessible.to_hash : instance.publicly_accessible) : nil
    read_replica_db_cluster_identifiers = instance.respond_to?(:read_replica_db_cluster_identifiers) ? (instance.read_replica_db_cluster_identifiers.respond_to?(:to_hash) ? instance.read_replica_db_cluster_identifiers.to_hash : instance.read_replica_db_cluster_identifiers) : nil
    read_replica_db_instance_identifiers = instance.respond_to?(:read_replica_db_instance_identifiers) ? (instance.read_replica_db_instance_identifiers.respond_to?(:to_hash) ? instance.read_replica_db_instance_identifiers.to_hash : instance.read_replica_db_instance_identifiers) : nil
    read_replica_source_db_instance_identifier = instance.respond_to?(:read_replica_source_db_instance_identifier) ? (instance.read_replica_source_db_instance_identifier.respond_to?(:to_hash) ? instance.read_replica_source_db_instance_identifier.to_hash : instance.read_replica_source_db_instance_identifier) : nil
    secondary_availability_zone = instance.respond_to?(:secondary_availability_zone) ? (instance.secondary_availability_zone.respond_to?(:to_hash) ? instance.secondary_availability_zone.to_hash : instance.secondary_availability_zone) : nil
    skip_final_snapshot = instance.respond_to?(:skip_final_snapshot) ? (instance.skip_final_snapshot.respond_to?(:to_hash) ? instance.skip_final_snapshot.to_hash : instance.skip_final_snapshot) : nil
    status_infos = instance.respond_to?(:status_infos) ? (instance.status_infos.respond_to?(:to_hash) ? instance.status_infos.to_hash : instance.status_infos) : nil
    storage_encrypted = instance.respond_to?(:storage_encrypted) ? (instance.storage_encrypted.respond_to?(:to_hash) ? instance.storage_encrypted.to_hash : instance.storage_encrypted) : nil
    storage_type = instance.respond_to?(:storage_type) ? (instance.storage_type.respond_to?(:to_hash) ? instance.storage_type.to_hash : instance.storage_type) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    tde_credential_arn = instance.respond_to?(:tde_credential_arn) ? (instance.tde_credential_arn.respond_to?(:to_hash) ? instance.tde_credential_arn.to_hash : instance.tde_credential_arn) : nil
    tde_credential_password = instance.respond_to?(:tde_credential_password) ? (instance.tde_credential_password.respond_to?(:to_hash) ? instance.tde_credential_password.to_hash : instance.tde_credential_password) : nil
    timezone = instance.respond_to?(:timezone) ? (instance.timezone.respond_to?(:to_hash) ? instance.timezone.to_hash : instance.timezone) : nil
    use_default_processor_features = instance.respond_to?(:use_default_processor_features) ? (instance.use_default_processor_features.respond_to?(:to_hash) ? instance.use_default_processor_features.to_hash : instance.use_default_processor_features) : nil
    vpc_security_group_ids = instance.respond_to?(:vpc_security_group_ids) ? (instance.vpc_security_group_ids.respond_to?(:to_hash) ? instance.vpc_security_group_ids.to_hash : instance.vpc_security_group_ids) : nil
    vpc_security_groups = instance.respond_to?(:vpc_security_groups) ? (instance.vpc_security_groups.respond_to?(:to_hash) ? instance.vpc_security_groups.to_hash : instance.vpc_security_groups) : nil

    db_instance = {}
    db_instance[:ensure] = :present
    db_instance[:object] = instance
    db_instance[:name] = instance.to_hash[self.namevar]
    db_instance[:allocated_storage] = allocated_storage unless allocated_storage.nil?
    db_instance[:allow_major_version_upgrade] = allow_major_version_upgrade unless allow_major_version_upgrade.nil?
    db_instance[:apply_immediately] = apply_immediately unless apply_immediately.nil?
    db_instance[:associated_roles] = associated_roles unless associated_roles.nil?
    db_instance[:auto_minor_version_upgrade] = auto_minor_version_upgrade unless auto_minor_version_upgrade.nil?
    db_instance[:availability_zone] = availability_zone unless availability_zone.nil?
    db_instance[:backup_retention_period] = backup_retention_period unless backup_retention_period.nil?
    db_instance[:ca_certificate_identifier] = ca_certificate_identifier unless ca_certificate_identifier.nil?
    db_instance[:character_set_name] = character_set_name unless character_set_name.nil?
    db_instance[:cloudwatch_logs_export_configuration] = cloudwatch_logs_export_configuration unless cloudwatch_logs_export_configuration.nil?
    db_instance[:copy_tags_to_snapshot] = copy_tags_to_snapshot unless copy_tags_to_snapshot.nil?
    db_instance[:db_cluster_identifier] = db_cluster_identifier unless db_cluster_identifier.nil?
    db_instance[:db_instance_arn] = db_instance_arn unless db_instance_arn.nil?
    db_instance[:db_instance_class] = db_instance_class unless db_instance_class.nil?
    db_instance[:db_instance_identifier] = db_instance_identifier unless db_instance_identifier.nil?
    db_instance[:db_instance_port] = db_instance_port unless db_instance_port.nil?
    db_instance[:db_instance_status] = db_instance_status unless db_instance_status.nil?
    db_instance[:dbi_resource_id] = dbi_resource_id unless dbi_resource_id.nil?
    db_instance[:db_name] = db_name unless db_name.nil?
    db_instance[:db_parameter_group_name] = db_parameter_group_name unless db_parameter_group_name.nil?
    db_instance[:db_parameter_groups] = db_parameter_groups unless db_parameter_groups.nil?
    db_instance[:db_port_number] = db_port_number unless db_port_number.nil?
    db_instance[:db_security_groups] = db_security_groups unless db_security_groups.nil?
    db_instance[:db_subnet_group] = db_subnet_group unless db_subnet_group.nil?
    db_instance[:db_subnet_group_name] = db_subnet_group_name unless db_subnet_group_name.nil?
    db_instance[:delete_automated_backups] = delete_automated_backups unless delete_automated_backups.nil?
    db_instance[:deletion_protection] = deletion_protection unless deletion_protection.nil?
    db_instance[:domain] = domain unless domain.nil?
    db_instance[:domain_iam_role_name] = domain_iam_role_name unless domain_iam_role_name.nil?
    db_instance[:domain_memberships] = domain_memberships unless domain_memberships.nil?
    db_instance[:enable_cloudwatch_logs_exports] = enable_cloudwatch_logs_exports unless enable_cloudwatch_logs_exports.nil?
    db_instance[:enabled_cloudwatch_logs_exports] = enabled_cloudwatch_logs_exports unless enabled_cloudwatch_logs_exports.nil?
    db_instance[:enable_iam_database_authentication] = enable_iam_database_authentication unless enable_iam_database_authentication.nil?
    db_instance[:enable_performance_insights] = enable_performance_insights unless enable_performance_insights.nil?
    db_instance[:endpoint] = endpoint unless endpoint.nil?
    db_instance[:engine] = engine unless engine.nil?
    db_instance[:engine_version] = engine_version unless engine_version.nil?
    db_instance[:enhanced_monitoring_resource_arn] = enhanced_monitoring_resource_arn unless enhanced_monitoring_resource_arn.nil?
    db_instance[:filters] = filters unless filters.nil?
    db_instance[:final_db_snapshot_identifier] = final_db_snapshot_identifier unless final_db_snapshot_identifier.nil?
    db_instance[:iam_database_authentication_enabled] = iam_database_authentication_enabled unless iam_database_authentication_enabled.nil?
    db_instance[:instance_create_time] = instance_create_time unless instance_create_time.nil?
    db_instance[:iops] = iops unless iops.nil?
    db_instance[:kms_key_id] = kms_key_id unless kms_key_id.nil?
    db_instance[:latest_restorable_time] = latest_restorable_time unless latest_restorable_time.nil?
    db_instance[:license_model] = license_model unless license_model.nil?
    db_instance[:listener_endpoint] = listener_endpoint unless listener_endpoint.nil?
    db_instance[:master_username] = master_username unless master_username.nil?
    db_instance[:master_user_password] = master_user_password unless master_user_password.nil?
    db_instance[:max_records] = max_records unless max_records.nil?
    db_instance[:monitoring_interval] = monitoring_interval unless monitoring_interval.nil?
    db_instance[:monitoring_role_arn] = monitoring_role_arn unless monitoring_role_arn.nil?
    db_instance[:multi_az] = multi_az unless multi_az.nil?
    db_instance[:new_db_instance_identifier] = new_db_instance_identifier unless new_db_instance_identifier.nil?
    db_instance[:option_group_memberships] = option_group_memberships unless option_group_memberships.nil?
    db_instance[:option_group_name] = option_group_name unless option_group_name.nil?
    db_instance[:pending_modified_values] = pending_modified_values unless pending_modified_values.nil?
    db_instance[:performance_insights_enabled] = performance_insights_enabled unless performance_insights_enabled.nil?
    db_instance[:performance_insights_kms_key_id] = performance_insights_kms_key_id unless performance_insights_kms_key_id.nil?
    db_instance[:performance_insights_retention_period] = performance_insights_retention_period unless performance_insights_retention_period.nil?
    db_instance[:port] = port unless port.nil?
    db_instance[:preferred_backup_window] = preferred_backup_window unless preferred_backup_window.nil?
    db_instance[:preferred_maintenance_window] = preferred_maintenance_window unless preferred_maintenance_window.nil?
    db_instance[:processor_features] = processor_features unless processor_features.nil?
    db_instance[:promotion_tier] = promotion_tier unless promotion_tier.nil?
    db_instance[:publicly_accessible] = publicly_accessible unless publicly_accessible.nil?
    db_instance[:read_replica_db_cluster_identifiers] = read_replica_db_cluster_identifiers unless read_replica_db_cluster_identifiers.nil?
    db_instance[:read_replica_db_instance_identifiers] = read_replica_db_instance_identifiers unless read_replica_db_instance_identifiers.nil?
    db_instance[:read_replica_source_db_instance_identifier] = read_replica_source_db_instance_identifier unless read_replica_source_db_instance_identifier.nil?
    db_instance[:secondary_availability_zone] = secondary_availability_zone unless secondary_availability_zone.nil?
    db_instance[:skip_final_snapshot] = skip_final_snapshot unless skip_final_snapshot.nil?
    db_instance[:status_infos] = status_infos unless status_infos.nil?
    db_instance[:storage_encrypted] = storage_encrypted unless storage_encrypted.nil?
    db_instance[:storage_type] = storage_type unless storage_type.nil?
    db_instance[:tags] = tags unless tags.nil?
    db_instance[:tde_credential_arn] = tde_credential_arn unless tde_credential_arn.nil?
    db_instance[:tde_credential_password] = tde_credential_password unless tde_credential_password.nil?
    db_instance[:timezone] = timezone unless timezone.nil?
    db_instance[:use_default_processor_features] = use_default_processor_features unless use_default_processor_features.nil?
    db_instance[:vpc_security_group_ids] = vpc_security_group_ids unless vpc_security_group_ids.nil?
    db_instance[:vpc_security_groups] = vpc_security_groups unless vpc_security_groups.nil?
    db_instance
  end

  def namevar
    :db_instance_identifier
  end

  def self.namevar
    :db_instance_identifier
  end

  def name?(hash)
    !hash[self.namevar].nil? && !hash[self.namevar].empty?
  end

  def self.name?(hash)
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
      client.create_db_instance(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))

      client = Aws::RDS::Client.new(region: region)
      client.modify_db_instance(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    db_instance = {}
          db_instance['allocated_storage'] = resource[:allocated_storage] unless resource[:allocated_storage].nil?
          db_instance['allow_major_version_upgrade'] = resource[:allow_major_version_upgrade] unless resource[:allow_major_version_upgrade].nil?
          db_instance['apply_immediately'] = resource[:apply_immediately] unless resource[:apply_immediately].nil?
          db_instance['auto_minor_version_upgrade'] = resource[:auto_minor_version_upgrade] unless resource[:auto_minor_version_upgrade].nil?
          db_instance['availability_zone'] = resource[:availability_zone] unless resource[:availability_zone].nil?
          db_instance['backup_retention_period'] = resource[:backup_retention_period] unless resource[:backup_retention_period].nil?
          db_instance['ca_certificate_identifier'] = resource[:ca_certificate_identifier] unless resource[:ca_certificate_identifier].nil?
          db_instance['character_set_name'] = resource[:character_set_name] unless resource[:character_set_name].nil?
          db_instance['cloudwatch_logs_export_configuration'] = resource[:cloudwatch_logs_export_configuration] unless resource[:cloudwatch_logs_export_configuration].nil?
          db_instance['copy_tags_to_snapshot'] = resource[:copy_tags_to_snapshot] unless resource[:copy_tags_to_snapshot].nil?
          db_instance['db_cluster_identifier'] = resource[:db_cluster_identifier] unless resource[:db_cluster_identifier].nil?
          db_instance['db_instance_class'] = resource[:db_instance_class] unless resource[:db_instance_class].nil?
          db_instance['db_instance_identifier'] = resource[:db_instance_identifier] unless resource[:db_instance_identifier].nil?
          db_instance['db_name'] = resource[:db_name] unless resource[:db_name].nil?
          db_instance['db_parameter_group_name'] = resource[:db_parameter_group_name] unless resource[:db_parameter_group_name].nil?
          db_instance['db_port_number'] = resource[:db_port_number] unless resource[:db_port_number].nil?
          db_instance['db_security_groups'] = resource[:db_security_groups] unless resource[:db_security_groups].nil?
          db_instance['db_subnet_group_name'] = resource[:db_subnet_group_name] unless resource[:db_subnet_group_name].nil?
          db_instance['delete_automated_backups'] = resource[:delete_automated_backups] unless resource[:delete_automated_backups].nil?
          db_instance['deletion_protection'] = resource[:deletion_protection] unless resource[:deletion_protection].nil?
          db_instance['domain'] = resource[:domain] unless resource[:domain].nil?
          db_instance['domain_iam_role_name'] = resource[:domain_iam_role_name] unless resource[:domain_iam_role_name].nil?
          db_instance['enable_cloudwatch_logs_exports'] = resource[:enable_cloudwatch_logs_exports] unless resource[:enable_cloudwatch_logs_exports].nil?
          db_instance['enable_iam_database_authentication'] = resource[:enable_iam_database_authentication] unless resource[:enable_iam_database_authentication].nil?
          db_instance['enable_performance_insights'] = resource[:enable_performance_insights] unless resource[:enable_performance_insights].nil?
          db_instance['engine'] = resource[:engine] unless resource[:engine].nil?
          db_instance['engine_version'] = resource[:engine_version] unless resource[:engine_version].nil?
          db_instance['filters'] = resource[:filters] unless resource[:filters].nil?
          db_instance['final_db_snapshot_identifier'] = resource[:final_db_snapshot_identifier] unless resource[:final_db_snapshot_identifier].nil?
          db_instance['iops'] = resource[:iops] unless resource[:iops].nil?
          db_instance['kms_key_id'] = resource[:kms_key_id] unless resource[:kms_key_id].nil?
          db_instance['license_model'] = resource[:license_model] unless resource[:license_model].nil?
          db_instance['master_username'] = resource[:master_username] unless resource[:master_username].nil?
          db_instance['master_user_password'] = resource[:master_user_password] unless resource[:master_user_password].nil?
          db_instance['max_records'] = resource[:max_records] unless resource[:max_records].nil?
          db_instance['monitoring_interval'] = resource[:monitoring_interval] unless resource[:monitoring_interval].nil?
          db_instance['monitoring_role_arn'] = resource[:monitoring_role_arn] unless resource[:monitoring_role_arn].nil?
          db_instance['multi_az'] = resource[:multi_az] unless resource[:multi_az].nil?
          db_instance['master_username'] = resource[:master_username] unless resource[:master_username].nil?
          db_instance['new_db_instance_identifier'] = resource[:new_db_instance_identifier] unless resource[:new_db_instance_identifier].nil?
          db_instance['option_group_name'] = resource[:option_group_name] unless resource[:option_group_name].nil?
          db_instance['performance_insights_kms_key_id'] = resource[:performance_insights_kms_key_id] unless resource[:performance_insights_kms_key_id].nil?
          db_instance['performance_insights_retention_period'] = resource[:performance_insights_retention_period] unless resource[:performance_insights_retention_period].nil?
          db_instance['port'] = resource[:port] unless resource[:port].nil?
          db_instance['preferred_backup_window'] = resource[:preferred_backup_window] unless resource[:preferred_backup_window].nil?
          db_instance['preferred_maintenance_window'] = resource[:preferred_maintenance_window] unless resource[:preferred_maintenance_window].nil?
          db_instance['processor_features'] = resource[:processor_features] unless resource[:processor_features].nil?
          db_instance['promotion_tier'] = resource[:promotion_tier] unless resource[:promotion_tier].nil?
          db_instance['publicly_accessible'] = resource[:publicly_accessible] unless resource[:publicly_accessible].nil?
          db_instance['storage_encrypted'] = resource[:storage_encrypted] unless resource[:storage_encrypted].nil?
          db_instance['storage_type'] = resource[:storage_type] unless resource[:storage_type].nil?
          db_instance['tags'] = resource[:tags] unless resource[:tags].nil?
          db_instance['tde_credential_arn'] = resource[:tde_credential_arn] unless resource[:tde_credential_arn].nil?
          db_instance['tde_credential_password'] = resource[:tde_credential_password] unless resource[:tde_credential_password].nil?
          db_instance['timezone'] = resource[:timezone] unless resource[:timezone].nil?
          db_instance['use_default_processor_features'] = resource[:use_default_processor_features] unless resource[:use_default_processor_features].nil?
          db_instance['vpc_security_group_ids'] = resource[:vpc_security_group_ids] unless resource[:vpc_security_group_ids].nil?
    db_instance[namevar] = resource[:name]
    symbolize(db_instance)
  end

  def build_hash_delete(resource)
    db_instance = {}
        db_instance['allocated_storage'] = resource[:allocated_storage] unless resource[:allocated_storage].nil?
        db_instance['allow_major_version_upgrade'] = resource[:allow_major_version_upgrade] unless resource[:allow_major_version_upgrade].nil?
        db_instance['apply_immediately'] = resource[:apply_immediately] unless resource[:apply_immediately].nil?
        db_instance['auto_minor_version_upgrade'] = resource[:auto_minor_version_upgrade] unless resource[:auto_minor_version_upgrade].nil?
        db_instance['availability_zone'] = resource[:availability_zone] unless resource[:availability_zone].nil?
        db_instance['backup_retention_period'] = resource[:backup_retention_period] unless resource[:backup_retention_period].nil?
        db_instance['ca_certificate_identifier'] = resource[:ca_certificate_identifier] unless resource[:ca_certificate_identifier].nil?
        db_instance['character_set_name'] = resource[:character_set_name] unless resource[:character_set_name].nil?
        db_instance['cloudwatch_logs_export_configuration'] = resource[:cloudwatch_logs_export_configuration] unless resource[:cloudwatch_logs_export_configuration].nil?
        db_instance['copy_tags_to_snapshot'] = resource[:copy_tags_to_snapshot] unless resource[:copy_tags_to_snapshot].nil?
        db_instance['db_cluster_identifier'] = resource[:db_cluster_identifier] unless resource[:db_cluster_identifier].nil?
        db_instance['db_instance_class'] = resource[:db_instance_class] unless resource[:db_instance_class].nil?
        db_instance['db_instance_identifier'] = resource[:db_instance_identifier] unless resource[:db_instance_identifier].nil?
        db_instance['db_name'] = resource[:db_name] unless resource[:db_name].nil?
        db_instance['db_parameter_group_name'] = resource[:db_parameter_group_name] unless resource[:db_parameter_group_name].nil?
        db_instance['db_port_number'] = resource[:db_port_number] unless resource[:db_port_number].nil?
        db_instance['db_security_groups'] = resource[:db_security_groups] unless resource[:db_security_groups].nil?
        db_instance['db_subnet_group_name'] = resource[:db_subnet_group_name] unless resource[:db_subnet_group_name].nil?
        db_instance['delete_automated_backups'] = resource[:delete_automated_backups] unless resource[:delete_automated_backups].nil?
        db_instance['deletion_protection'] = resource[:deletion_protection] unless resource[:deletion_protection].nil?
        db_instance['domain'] = resource[:domain] unless resource[:domain].nil?
        db_instance['domain_iam_role_name'] = resource[:domain_iam_role_name] unless resource[:domain_iam_role_name].nil?
        db_instance['enable_cloudwatch_logs_exports'] = resource[:enable_cloudwatch_logs_exports] unless resource[:enable_cloudwatch_logs_exports].nil?
        db_instance['enable_iam_database_authentication'] = resource[:enable_iam_database_authentication] unless resource[:enable_iam_database_authentication].nil?
        db_instance['enable_performance_insights'] = resource[:enable_performance_insights] unless resource[:enable_performance_insights].nil?
        db_instance['engine'] = resource[:engine] unless resource[:engine].nil?
        db_instance['engine_version'] = resource[:engine_version] unless resource[:engine_version].nil?
        db_instance['filters'] = resource[:filters] unless resource[:filters].nil?
        db_instance['final_db_snapshot_identifier'] = resource[:final_db_snapshot_identifier] unless resource[:final_db_snapshot_identifier].nil?
        db_instance['iops'] = resource[:iops] unless resource[:iops].nil?
        db_instance['kms_key_id'] = resource[:kms_key_id] unless resource[:kms_key_id].nil?
        db_instance['license_model'] = resource[:license_model] unless resource[:license_model].nil?
        db_instance['master_username'] = resource[:master_username] unless resource[:master_username].nil?
        db_instance['master_user_password'] = resource[:master_user_password] unless resource[:master_user_password].nil?
        db_instance['max_records'] = resource[:max_records] unless resource[:max_records].nil?
        db_instance['monitoring_interval'] = resource[:monitoring_interval] unless resource[:monitoring_interval].nil?
        db_instance['monitoring_role_arn'] = resource[:monitoring_role_arn] unless resource[:monitoring_role_arn].nil?
        db_instance['multi_az'] = resource[:multi_az] unless resource[:multi_az].nil?
        db_instance['master_username'] = resource[:master_username] unless resource[:master_username].nil?
        db_instance['new_db_instance_identifier'] = resource[:new_db_instance_identifier] unless resource[:new_db_instance_identifier].nil?
        db_instance['option_group_name'] = resource[:option_group_name] unless resource[:option_group_name].nil?
        db_instance['performance_insights_kms_key_id'] = resource[:performance_insights_kms_key_id] unless resource[:performance_insights_kms_key_id].nil?
        db_instance['performance_insights_retention_period'] = resource[:performance_insights_retention_period] unless resource[:performance_insights_retention_period].nil?
        db_instance['port'] = resource[:port] unless resource[:port].nil?
        db_instance['preferred_backup_window'] = resource[:preferred_backup_window] unless resource[:preferred_backup_window].nil?
        db_instance['preferred_maintenance_window'] = resource[:preferred_maintenance_window] unless resource[:preferred_maintenance_window].nil?
        db_instance['processor_features'] = resource[:processor_features] unless resource[:processor_features].nil?
        db_instance['promotion_tier'] = resource[:promotion_tier] unless resource[:promotion_tier].nil?
        db_instance['publicly_accessible'] = resource[:publicly_accessible] unless resource[:publicly_accessible].nil?
        db_instance['skip_final_snapshot'] = resource[:skip_final_snapshot] unless resource[:skip_final_snapshot].nil?
        db_instance['storage_encrypted'] = resource[:storage_encrypted] unless resource[:storage_encrypted].nil?
        db_instance['storage_type'] = resource[:storage_type] unless resource[:storage_type].nil?
        db_instance['tags'] = resource[:tags] unless resource[:tags].nil?
        db_instance['tde_credential_arn'] = resource[:tde_credential_arn] unless resource[:tde_credential_arn].nil?
        db_instance['tde_credential_password'] = resource[:tde_credential_password] unless resource[:tde_credential_password].nil?
        db_instance['timezone'] = resource[:timezone] unless resource[:timezone].nil?
        db_instance['use_default_processor_features'] = resource[:use_default_processor_features] unless resource[:use_default_processor_features].nil?
        db_instance['vpc_security_group_ids'] = resource[:vpc_security_group_ids] unless resource[:vpc_security_group_ids].nil?
    db_instance[namevar] = resource[:name]
    symbolize(db_instance)
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
    client.delete_db_instance(new_hash)
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
