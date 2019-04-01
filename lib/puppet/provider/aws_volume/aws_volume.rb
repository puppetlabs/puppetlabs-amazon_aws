require 'puppet/resource_api'


require 'aws-sdk-ec2'






# AwsVolume class
class Puppet::Provider::AwsVolume::AwsVolume
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)
    all_instances = []
    client.describe_volumes.each do |response|
      response.volumes.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    encrypted = instance.respond_to?(:encrypted) ? (instance.encrypted.respond_to?(:to_hash) ? instance.encrypted.to_hash : instance.encrypted) : nil
    end_time = instance.respond_to?(:end_time) ? (instance.end_time.respond_to?(:to_hash) ? instance.end_time.to_hash : instance.end_time) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    iops = instance.respond_to?(:iops) ? (instance.iops.respond_to?(:to_hash) ? instance.iops.to_hash : instance.iops) : nil
    kms_key_id = instance.respond_to?(:kms_key_id) ? (instance.kms_key_id.respond_to?(:to_hash) ? instance.kms_key_id.to_hash : instance.kms_key_id) : nil
    max_results = instance.respond_to?(:max_results) ? (instance.max_results.respond_to?(:to_hash) ? instance.max_results.to_hash : instance.max_results) : nil
    modification_state = instance.respond_to?(:modification_state) ? (instance.modification_state.respond_to?(:to_hash) ? instance.modification_state.to_hash : instance.modification_state) : nil
    next_token = instance.respond_to?(:next_token) ? (instance.next_token.respond_to?(:to_hash) ? instance.next_token.to_hash : instance.next_token) : nil
    original_iops = instance.respond_to?(:original_iops) ? (instance.original_iops.respond_to?(:to_hash) ? instance.original_iops.to_hash : instance.original_iops) : nil
    original_size = instance.respond_to?(:original_size) ? (instance.original_size.respond_to?(:to_hash) ? instance.original_size.to_hash : instance.original_size) : nil
    original_volume_type = instance.respond_to?(:original_volume_type) ? (instance.original_volume_type.respond_to?(:to_hash) ? instance.original_volume_type.to_hash : instance.original_volume_type) : nil
    progress = instance.respond_to?(:progress) ? (instance.progress.respond_to?(:to_hash) ? instance.progress.to_hash : instance.progress) : nil
    size = instance.respond_to?(:size) ? (instance.size.respond_to?(:to_hash) ? instance.size.to_hash : instance.size) : nil
    snapshot_id = instance.respond_to?(:snapshot_id) ? (instance.snapshot_id.respond_to?(:to_hash) ? instance.snapshot_id.to_hash : instance.snapshot_id) : nil
    start_time = instance.respond_to?(:start_time) ? (instance.start_time.respond_to?(:to_hash) ? instance.start_time.to_hash : instance.start_time) : nil
    status_message = instance.respond_to?(:status_message) ? (instance.status_message.respond_to?(:to_hash) ? instance.status_message.to_hash : instance.status_message) : nil
    tag_specifications = instance.respond_to?(:tag_specifications) ? (instance.tag_specifications.respond_to?(:to_hash) ? instance.tag_specifications.to_hash : instance.tag_specifications) : nil
    target_iops = instance.respond_to?(:target_iops) ? (instance.target_iops.respond_to?(:to_hash) ? instance.target_iops.to_hash : instance.target_iops) : nil
    target_size = instance.respond_to?(:target_size) ? (instance.target_size.respond_to?(:to_hash) ? instance.target_size.to_hash : instance.target_size) : nil
    target_volume_type = instance.respond_to?(:target_volume_type) ? (instance.target_volume_type.respond_to?(:to_hash) ? instance.target_volume_type.to_hash : instance.target_volume_type) : nil
    volume_id = instance.respond_to?(:volume_id) ? (instance.volume_id.respond_to?(:to_hash) ? instance.volume_id.to_hash : instance.volume_id) : nil
    volume_ids = instance.respond_to?(:volume_ids) ? (instance.volume_ids.respond_to?(:to_hash) ? instance.volume_ids.to_hash : instance.volume_ids) : nil
    volume_type = instance.respond_to?(:volume_type) ? (instance.volume_type.respond_to?(:to_hash) ? instance.volume_type.to_hash : instance.volume_type) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:availability_zone] = availability_zone unless availability_zone.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:encrypted] = encrypted unless encrypted.nil?
    hash[:end_time] = end_time unless end_time.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:iops] = iops unless iops.nil?
    hash[:kms_key_id] = kms_key_id unless kms_key_id.nil?
    hash[:max_results] = max_results unless max_results.nil?
    hash[:modification_state] = modification_state unless modification_state.nil?
    hash[:next_token] = next_token unless next_token.nil?
    hash[:original_iops] = original_iops unless original_iops.nil?
    hash[:original_size] = original_size unless original_size.nil?
    hash[:original_volume_type] = original_volume_type unless original_volume_type.nil?
    hash[:progress] = progress unless progress.nil?
    hash[:size] = size unless size.nil?
    hash[:snapshot_id] = snapshot_id unless snapshot_id.nil?
    hash[:start_time] = start_time unless start_time.nil?
    hash[:status_message] = status_message unless status_message.nil?
    hash[:tag_specifications] = tag_specifications unless tag_specifications.nil?
    hash[:target_iops] = target_iops unless target_iops.nil?
    hash[:target_size] = target_size unless target_size.nil?
    hash[:target_volume_type] = target_volume_type unless target_volume_type.nil?
    hash[:volume_id] = volume_id unless volume_id.nil?
    hash[:volume_ids] = volume_ids unless volume_ids.nil?
    hash[:volume_type] = volume_type unless volume_type.nil?
    hash
  end
  def namevar
    :volume_id
  end

  def self.namevar
    :volume_id
  end

  def name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end

  def name_from_tag(instance)
    tags = instance.respond_to?(:tags) ? instance.tags : nil
    name = tags.find { |x| x.key == 'Name' } unless tags.nil?
    name.value unless name.nil?
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
        # if update method exists call update, else delete and recreate the resource

        update(context, name, should)

      end
    end
  end

  def region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def create(context, name, should)
    context.creating(name) do
      new_hash = symbolize(build_hash(should))

      client = Aws::EC2::Client.new(region: region)
      response = client.create_volume(new_hash)
      res = response.respond_to?(:volume) ? response.volume : response
      client.create_tags(
        resources: [res.to_hash[namevar]],
        tags: [{ key: 'Name', value: name }],
      )
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))
      client = Aws::EC2::Client.new(region: region)
      client.modify_volume(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    volume = {}
    volume['availability_zone'] = resource[:availability_zone] unless resource[:availability_zone].nil?
    volume['dry_run'] = resource[:dry_run] unless resource[:dry_run].nil?
    volume['encrypted'] = resource[:encrypted] unless resource[:encrypted].nil?
    volume['filters'] = resource[:filters] unless resource[:filters].nil?
    volume['snapshot_id'] = resource[:snapshot_id] unless resource[:snapshot_id].nil?
    volume['iops'] = resource[:iops] unless resource[:iops].nil?
    volume['kms_key_id'] = resource[:kms_key_id] unless resource[:kms_key_id].nil?
    volume['max_results'] = resource[:max_results] unless resource[:max_results].nil?
    volume['next_token'] = resource[:next_token] unless resource[:next_token].nil?
    volume['size'] = resource[:size] unless resource[:size].nil?
    volume['snapshot_id'] = resource[:snapshot_id] unless resource[:snapshot_id].nil?
    volume['tag_specifications'] = resource[:tag_specifications] unless resource[:tag_specifications].nil?
    volume['volume_id'] = resource[:volume_id] unless resource[:volume_id].nil?
    volume['volume_ids'] = resource[:volume_ids] unless resource[:volume_ids].nil?
    volume['volume_type'] = resource[:volume_type] unless resource[:volume_type].nil?
    volume
  end

  def self.build_key_values
    key_values = {}

    key_values
  end

  def destroy
    delete(resource)
  end

  def delete(should)
    client = Aws::EC2::Client.new(region: region)
    myhash = {}
    @property_hash.each do |response|
      if response[:name] == should[:name]
        myhash = response
      end
    end
    client.delete_volume(namevar => myhash[namevar])
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
