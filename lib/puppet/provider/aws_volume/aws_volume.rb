require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-ec2"


Puppet::Type.type(:aws_volume).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
    
  def namevar
    :volume_id
  end

  # Properties

  def availability_zone=(value)
    Puppet.info("availability_zone setter called to change to #{value}")
    @property_flush[:availability_zone] = value
  end

  def dry_run=(value)
    Puppet.info("dry_run setter called to change to #{value}")
    @property_flush[:dry_run] = value
  end

  def encrypted=(value)
    Puppet.info("encrypted setter called to change to #{value}")
    @property_flush[:encrypted] = value
  end

  def end_time=(value)
    Puppet.info("end_time setter called to change to #{value}")
    @property_flush[:end_time] = value
  end

  def filters=(value)
    Puppet.info("filters setter called to change to #{value}")
    @property_flush[:filters] = value
  end

  def iops=(value)
    Puppet.info("iops setter called to change to #{value}")
    @property_flush[:iops] = value
  end

  def kms_key_id=(value)
    Puppet.info("kms_key_id setter called to change to #{value}")
    @property_flush[:kms_key_id] = value
  end

  def max_results=(value)
    Puppet.info("max_results setter called to change to #{value}")
    @property_flush[:max_results] = value
  end

  def modification_state=(value)
    Puppet.info("modification_state setter called to change to #{value}")
    @property_flush[:modification_state] = value
  end

  def next_token=(value)
    Puppet.info("next_token setter called to change to #{value}")
    @property_flush[:next_token] = value
  end

  def original_iops=(value)
    Puppet.info("original_iops setter called to change to #{value}")
    @property_flush[:original_iops] = value
  end

  def original_size=(value)
    Puppet.info("original_size setter called to change to #{value}")
    @property_flush[:original_size] = value
  end

  def original_volume_type=(value)
    Puppet.info("original_volume_type setter called to change to #{value}")
    @property_flush[:original_volume_type] = value
  end

  def progress=(value)
    Puppet.info("progress setter called to change to #{value}")
    @property_flush[:progress] = value
  end

  def size=(value)
    Puppet.info("size setter called to change to #{value}")
    @property_flush[:size] = value
  end

  def snapshot_id=(value)
    Puppet.info("snapshot_id setter called to change to #{value}")
    @property_flush[:snapshot_id] = value
  end

  def start_time=(value)
    Puppet.info("start_time setter called to change to #{value}")
    @property_flush[:start_time] = value
  end

  def status_message=(value)
    Puppet.info("status_message setter called to change to #{value}")
    @property_flush[:status_message] = value
  end

  def tag_specifications=(value)
    Puppet.info("tag_specifications setter called to change to #{value}")
    @property_flush[:tag_specifications] = value
  end

  def target_iops=(value)
    Puppet.info("target_iops setter called to change to #{value}")
    @property_flush[:target_iops] = value
  end

  def target_size=(value)
    Puppet.info("target_size setter called to change to #{value}")
    @property_flush[:target_size] = value
  end

  def target_volume_type=(value)
    Puppet.info("target_volume_type setter called to change to #{value}")
    @property_flush[:target_volume_type] = value
  end

  def volume_id=(value)
    Puppet.info("volume_id setter called to change to #{value}")
    @property_flush[:volume_id] = value
  end

  def volume_ids=(value)
    Puppet.info("volume_ids setter called to change to #{value}")
    @property_flush[:volume_ids] = value
  end

  def volume_type=(value)
    Puppet.info("volume_type setter called to change to #{value}")
    @property_flush[:volume_type] = value
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
    client.describe_volumes.each do |response|
      response.volumes.each do |i|
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
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone ) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run ) : nil
    encrypted = instance.respond_to?(:encrypted) ? (instance.encrypted.respond_to?(:to_hash) ? instance.encrypted.to_hash : instance.encrypted ) : nil
    end_time = instance.respond_to?(:end_time) ? (instance.end_time.respond_to?(:to_hash) ? instance.end_time.to_hash : instance.end_time ) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters ) : nil
    iops = instance.respond_to?(:iops) ? (instance.iops.respond_to?(:to_hash) ? instance.iops.to_hash : instance.iops ) : nil
    kms_key_id = instance.respond_to?(:kms_key_id) ? (instance.kms_key_id.respond_to?(:to_hash) ? instance.kms_key_id.to_hash : instance.kms_key_id ) : nil
    max_results = instance.respond_to?(:max_results) ? (instance.max_results.respond_to?(:to_hash) ? instance.max_results.to_hash : instance.max_results ) : nil
    modification_state = instance.respond_to?(:modification_state) ? (instance.modification_state.respond_to?(:to_hash) ? instance.modification_state.to_hash : instance.modification_state ) : nil
    next_token = instance.respond_to?(:next_token) ? (instance.next_token.respond_to?(:to_hash) ? instance.next_token.to_hash : instance.next_token ) : nil
    original_iops = instance.respond_to?(:original_iops) ? (instance.original_iops.respond_to?(:to_hash) ? instance.original_iops.to_hash : instance.original_iops ) : nil
    original_size = instance.respond_to?(:original_size) ? (instance.original_size.respond_to?(:to_hash) ? instance.original_size.to_hash : instance.original_size ) : nil
    original_volume_type = instance.respond_to?(:original_volume_type) ? (instance.original_volume_type.respond_to?(:to_hash) ? instance.original_volume_type.to_hash : instance.original_volume_type ) : nil
    progress = instance.respond_to?(:progress) ? (instance.progress.respond_to?(:to_hash) ? instance.progress.to_hash : instance.progress ) : nil
    size = instance.respond_to?(:size) ? (instance.size.respond_to?(:to_hash) ? instance.size.to_hash : instance.size ) : nil
    snapshot_id = instance.respond_to?(:snapshot_id) ? (instance.snapshot_id.respond_to?(:to_hash) ? instance.snapshot_id.to_hash : instance.snapshot_id ) : nil
    start_time = instance.respond_to?(:start_time) ? (instance.start_time.respond_to?(:to_hash) ? instance.start_time.to_hash : instance.start_time ) : nil
    status_message = instance.respond_to?(:status_message) ? (instance.status_message.respond_to?(:to_hash) ? instance.status_message.to_hash : instance.status_message ) : nil
    tag_specifications = instance.respond_to?(:tag_specifications) ? (instance.tag_specifications.respond_to?(:to_hash) ? instance.tag_specifications.to_hash : instance.tag_specifications ) : nil
    target_iops = instance.respond_to?(:target_iops) ? (instance.target_iops.respond_to?(:to_hash) ? instance.target_iops.to_hash : instance.target_iops ) : nil
    target_size = instance.respond_to?(:target_size) ? (instance.target_size.respond_to?(:to_hash) ? instance.target_size.to_hash : instance.target_size ) : nil
    target_volume_type = instance.respond_to?(:target_volume_type) ? (instance.target_volume_type.respond_to?(:to_hash) ? instance.target_volume_type.to_hash : instance.target_volume_type ) : nil
    volume_id = instance.respond_to?(:volume_id) ? (instance.volume_id.respond_to?(:to_hash) ? instance.volume_id.to_hash : instance.volume_id ) : nil
    volume_ids = instance.respond_to?(:volume_ids) ? (instance.volume_ids.respond_to?(:to_hash) ? instance.volume_ids.to_hash : instance.volume_ids ) : nil
    volume_type = instance.respond_to?(:volume_type) ? (instance.volume_type.respond_to?(:to_hash) ? instance.volume_type.to_hash : instance.volume_type ) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) and instance.tags.size > 0
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) and instance.tag_set.size > 0

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

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::EC2::Client.new(region: self.class.get_region)
    response = client.create_volume(build_hash)
    res = response.respond_to?(:volume) ? response.volume : response
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
    volume = {}
    if @is_create || @is_update
      volume[:availability_zone] = resource[:availability_zone] unless resource[:availability_zone].nil?
      volume[:dry_run] = resource[:dry_run] unless resource[:dry_run].nil?
      volume[:encrypted] = resource[:encrypted] unless resource[:encrypted].nil?
      volume[:filters] = resource[:filters] unless resource[:filters].nil?
      volume[:snapshot_id] = resource[:snapshot_id] unless resource[:snapshot_id].nil?
      volume[:iops] = resource[:iops] unless resource[:iops].nil?
      volume[:kms_key_id] = resource[:kms_key_id] unless resource[:kms_key_id].nil?
      volume[:max_results] = resource[:max_results] unless resource[:max_results].nil?
      volume[:next_token] = resource[:next_token] unless resource[:next_token].nil?
      volume[:size] = resource[:size] unless resource[:size].nil?
      volume[:snapshot_id] = resource[:snapshot_id] unless resource[:snapshot_id].nil?
      volume[:tag_specifications] = resource[:tag_specifications] unless resource[:tag_specifications].nil?
      volume[:volume_id] = resource[:volume_id] unless resource[:volume_id].nil?
      volume[:volume_ids] = resource[:volume_ids] unless resource[:volume_ids].nil?
      volume[:volume_type] = resource[:volume_type] unless resource[:volume_type].nil?
    end
    return symbolize(volume)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info("Calling operation delete_volume")
    client = Aws::EC2::Client.new(region: self.class.get_region)
    client.delete_volume({namevar => resource.provider.property_hash[namevar]})
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
