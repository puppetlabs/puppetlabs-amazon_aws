require 'puppet/resource_api'


require 'aws-sdk-rds'






# AwsDbSnapshot class
class Puppet::Provider::AwsDbSnapshot::AwsDbSnapshot
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client        = Aws::RDS::Client.new(region: region)
    all_instances = []
    client.describe_db_snapshots.each do |response|
      response.db_snapshots.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances

  end

  def instance_to_hash(instance)
    allocated_storage = instance.respond_to?(:allocated_storage) ? (instance.allocated_storage.respond_to?(:to_hash) ? instance.allocated_storage.to_hash : instance.allocated_storage) : nil
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone) : nil
    db_instance_identifier = instance.respond_to?(:db_instance_identifier) ? (instance.db_instance_identifier.respond_to?(:to_hash) ? instance.db_instance_identifier.to_hash : instance.db_instance_identifier) : nil
    dbi_resource_id = instance.respond_to?(:dbi_resource_id) ? (instance.dbi_resource_id.respond_to?(:to_hash) ? instance.dbi_resource_id.to_hash : instance.dbi_resource_id) : nil
    db_snapshot_arn = instance.respond_to?(:db_snapshot_arn) ? (instance.db_snapshot_arn.respond_to?(:to_hash) ? instance.db_snapshot_arn.to_hash : instance.db_snapshot_arn) : nil
    db_snapshot_identifier = instance.respond_to?(:db_snapshot_identifier) ? (instance.db_snapshot_identifier.respond_to?(:to_hash) ? instance.db_snapshot_identifier.to_hash : instance.db_snapshot_identifier) : nil
    encrypted = instance.respond_to?(:encrypted) ? (instance.encrypted.respond_to?(:to_hash) ? instance.encrypted.to_hash : instance.encrypted) : nil
    engine = instance.respond_to?(:engine) ? (instance.engine.respond_to?(:to_hash) ? instance.engine.to_hash : instance.engine) : nil
    engine_version = instance.respond_to?(:engine_version) ? (instance.engine_version.respond_to?(:to_hash) ? instance.engine_version.to_hash : instance.engine_version) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    iam_database_authentication_enabled = instance.respond_to?(:iam_database_authentication_enabled) ? (instance.iam_database_authentication_enabled.respond_to?(:to_hash) ? instance.iam_database_authentication_enabled.to_hash : instance.iam_database_authentication_enabled) : nil
    include_public = instance.respond_to?(:include_public) ? (instance.include_public.respond_to?(:to_hash) ? instance.include_public.to_hash : instance.include_public) : nil
    include_shared = instance.respond_to?(:include_shared) ? (instance.include_shared.respond_to?(:to_hash) ? instance.include_shared.to_hash : instance.include_shared) : nil
    instance_create_time = instance.respond_to?(:instance_create_time) ? (instance.instance_create_time.respond_to?(:to_hash) ? instance.instance_create_time.to_hash : instance.instance_create_time) : nil
    iops = instance.respond_to?(:iops) ? (instance.iops.respond_to?(:to_hash) ? instance.iops.to_hash : instance.iops) : nil
    kms_key_id = instance.respond_to?(:kms_key_id) ? (instance.kms_key_id.respond_to?(:to_hash) ? instance.kms_key_id.to_hash : instance.kms_key_id) : nil
    license_model = instance.respond_to?(:license_model) ? (instance.license_model.respond_to?(:to_hash) ? instance.license_model.to_hash : instance.license_model) : nil
    master_username = instance.respond_to?(:master_username) ? (instance.master_username.respond_to?(:to_hash) ? instance.master_username.to_hash : instance.master_username) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records) : nil
    option_group_name = instance.respond_to?(:option_group_name) ? (instance.option_group_name.respond_to?(:to_hash) ? instance.option_group_name.to_hash : instance.option_group_name) : nil
    percent_progress = instance.respond_to?(:percent_progress) ? (instance.percent_progress.respond_to?(:to_hash) ? instance.percent_progress.to_hash : instance.percent_progress) : nil
    port = instance.respond_to?(:port) ? (instance.port.respond_to?(:to_hash) ? instance.port.to_hash : instance.port) : nil
    processor_features = instance.respond_to?(:processor_features) ? (instance.processor_features.respond_to?(:to_hash) ? instance.processor_features.to_hash : instance.processor_features) : nil
    snapshot_create_time = instance.respond_to?(:snapshot_create_time) ? (instance.snapshot_create_time.respond_to?(:to_hash) ? instance.snapshot_create_time.to_hash : instance.snapshot_create_time) : nil
    snapshot_type = instance.respond_to?(:snapshot_type) ? (instance.snapshot_type.respond_to?(:to_hash) ? instance.snapshot_type.to_hash : instance.snapshot_type) : nil
    source_db_snapshot_identifier = instance.respond_to?(:source_db_snapshot_identifier) ? (instance.source_db_snapshot_identifier.respond_to?(:to_hash) ? instance.source_db_snapshot_identifier.to_hash : instance.source_db_snapshot_identifier) : nil
    source_region = instance.respond_to?(:source_region) ? (instance.source_region.respond_to?(:to_hash) ? instance.source_region.to_hash : instance.source_region) : nil
    status = instance.respond_to?(:status) ? (instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status) : nil
    storage_type = instance.respond_to?(:storage_type) ? (instance.storage_type.respond_to?(:to_hash) ? instance.storage_type.to_hash : instance.storage_type) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    tde_credential_arn = instance.respond_to?(:tde_credential_arn) ? (instance.tde_credential_arn.respond_to?(:to_hash) ? instance.tde_credential_arn.to_hash : instance.tde_credential_arn) : nil
    timezone = instance.respond_to?(:timezone) ? (instance.timezone.respond_to?(:to_hash) ? instance.timezone.to_hash : instance.timezone) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    db_snapshot = {}
    db_snapshot[:ensure] = :present
    db_snapshot[:object] = instance
    db_snapshot[:name] = instance.to_hash[self.namevar]
    db_snapshot[:allocated_storage] = allocated_storage unless allocated_storage.nil?
    db_snapshot[:availability_zone] = availability_zone unless availability_zone.nil?
    db_snapshot[:db_instance_identifier] = db_instance_identifier unless db_instance_identifier.nil?
    db_snapshot[:dbi_resource_id] = dbi_resource_id unless dbi_resource_id.nil?
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

  def namevar
    :db_snapshot_identifier
  end

  def self.namevar
    :db_snapshot_identifier
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
      client.create_db_snapshot(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))

      client = Aws::RDS::Client.new(region: region)
      client.modify_db_snapshot(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    db_snapshot = {}
    db_snapshot['db_instance_identifier'] = resource[:db_instance_identifier] unless resource[:db_instance_identifier].nil?
    db_snapshot['dbi_resource_id'] = resource[:dbi_resource_id] unless resource[:dbi_resource_id].nil?
    db_snapshot['db_snapshot_identifier'] = resource[:db_snapshot_identifier] unless resource[:db_snapshot_identifier].nil?
    db_snapshot['engine_version'] = resource[:engine_version] unless resource[:engine_version].nil?
    db_snapshot['filters'] = resource[:filters] unless resource[:filters].nil?
    db_snapshot['include_public'] = resource[:include_public] unless resource[:include_public].nil?
    db_snapshot['include_shared'] = resource[:include_shared] unless resource[:include_shared].nil?
    db_snapshot['max_records'] = resource[:max_records] unless resource[:max_records].nil?
    db_snapshot['option_group_name'] = resource[:option_group_name] unless resource[:option_group_name].nil?
    db_snapshot['option_group_name'] = resource[:option_group_name] unless resource[:option_group_name].nil?
    db_snapshot['snapshot_type'] = resource[:snapshot_type] unless resource[:snapshot_type].nil?
    db_snapshot['tags'] = resource[:tags] unless resource[:tags].nil?
    symbolize(db_snapshot)
  end

  def self.build_key_values
    key_values = {}
    key_values
  end

  def destroy
    delete(resource)
  end

  def delete(should)
    new_hash = symbolize(build_hash(should))
    client = Aws::RDS::Client.new(region: region)
    client.delete_db_snapshot(new_hash)
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
