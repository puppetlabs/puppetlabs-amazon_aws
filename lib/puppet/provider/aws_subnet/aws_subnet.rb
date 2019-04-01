require 'puppet/resource_api'


require 'aws-sdk-ec2'






# AwsSubnet class
class Puppet::Provider::AwsSubnet::AwsSubnet
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)
    all_instances = []
    client.describe_subnets.each do |response|
      response.subnets.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    assign_ipv6_address_on_creation = instance.respond_to?(:assign_ipv6_address_on_creation) ? (instance.assign_ipv6_address_on_creation.respond_to?(:to_hash) ? instance.assign_ipv6_address_on_creation.to_hash : instance.assign_ipv6_address_on_creation) : nil
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone) : nil
    availability_zone_id = instance.respond_to?(:availability_zone_id) ? (instance.availability_zone_id.respond_to?(:to_hash) ? instance.availability_zone_id.to_hash : instance.availability_zone_id) : nil
    available_ip_address_count = instance.respond_to?(:available_ip_address_count) ? (instance.available_ip_address_count.respond_to?(:to_hash) ? instance.available_ip_address_count.to_hash : instance.available_ip_address_count) : nil
    cidr_block = instance.respond_to?(:cidr_block) ? (instance.cidr_block.respond_to?(:to_hash) ? instance.cidr_block.to_hash : instance.cidr_block) : nil
    default_for_az = instance.respond_to?(:default_for_az) ? (instance.default_for_az.respond_to?(:to_hash) ? instance.default_for_az.to_hash : instance.default_for_az) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    ipv6_cidr_block = instance.respond_to?(:ipv6_cidr_block) ? (instance.ipv6_cidr_block.respond_to?(:to_hash) ? instance.ipv6_cidr_block.to_hash : instance.ipv6_cidr_block) : nil
    ipv6_cidr_block_association_set = instance.respond_to?(:ipv6_cidr_block_association_set) ? (instance.ipv6_cidr_block_association_set.respond_to?(:to_hash) ? instance.ipv6_cidr_block_association_set.to_hash : instance.ipv6_cidr_block_association_set) : nil
    map_public_ip_on_launch = instance.respond_to?(:map_public_ip_on_launch) ? (instance.map_public_ip_on_launch.respond_to?(:to_hash) ? instance.map_public_ip_on_launch.to_hash : instance.map_public_ip_on_launch) : nil
    owner_id = instance.respond_to?(:owner_id) ? (instance.owner_id.respond_to?(:to_hash) ? instance.owner_id.to_hash : instance.owner_id) : nil
    state = instance.respond_to?(:state) ? (instance.state.respond_to?(:to_hash) ? instance.state.to_hash : instance.state) : nil
    subnet_arn = instance.respond_to?(:subnet_arn) ? (instance.subnet_arn.respond_to?(:to_hash) ? instance.subnet_arn.to_hash : instance.subnet_arn) : nil
    subnet_id = instance.respond_to?(:subnet_id) ? (instance.subnet_id.respond_to?(:to_hash) ? instance.subnet_id.to_hash : instance.subnet_id) : nil
    subnet_ids = instance.respond_to?(:subnet_ids) ? (instance.subnet_ids.respond_to?(:to_hash) ? instance.subnet_ids.to_hash : instance.subnet_ids) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:assign_ipv6_address_on_creation] = assign_ipv6_address_on_creation unless assign_ipv6_address_on_creation.nil?
    hash[:availability_zone] = availability_zone unless availability_zone.nil?
    hash[:availability_zone_id] = availability_zone_id unless availability_zone_id.nil?
    hash[:available_ip_address_count] = available_ip_address_count unless available_ip_address_count.nil?
    hash[:cidr_block] = cidr_block unless cidr_block.nil?
    hash[:default_for_az] = default_for_az unless default_for_az.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:ipv6_cidr_block] = ipv6_cidr_block unless ipv6_cidr_block.nil?
    hash[:ipv6_cidr_block_association_set] = ipv6_cidr_block_association_set unless ipv6_cidr_block_association_set.nil?
    hash[:map_public_ip_on_launch] = map_public_ip_on_launch unless map_public_ip_on_launch.nil?
    hash[:owner_id] = owner_id unless owner_id.nil?
    hash[:state] = state unless state.nil?
    hash[:subnet_arn] = subnet_arn unless subnet_arn.nil?
    hash[:subnet_id] = subnet_id unless subnet_id.nil?
    hash[:subnet_ids] = subnet_ids unless subnet_ids.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:vpc_id] = vpc_id unless vpc_id.nil?
    hash
  end
  def namevar
    :subnet_id
  end

  def self.namevar
    :subnet_id
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

        context.deleting(name) do
          delete(should) unless noop
        end
        create(context, name, should) unless noop

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
      response = client.create_subnet(new_hash)
      res = response.respond_to?(:subnet) ? response.subnet : response
      client.create_tags(
        resources: [res.to_hash[namevar]],
        tags: [{ key: 'Name', value: name }],
      )
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end



  def build_hash(resource)
    subnet = {}
    subnet['availability_zone'] = resource[:availability_zone] unless resource[:availability_zone].nil?
    subnet['availability_zone_id'] = resource[:availability_zone_id] unless resource[:availability_zone_id].nil?
    subnet['cidr_block'] = resource[:cidr_block] unless resource[:cidr_block].nil?
    subnet['dry_run'] = resource[:dry_run] unless resource[:dry_run].nil?
    subnet['filters'] = resource[:filters] unless resource[:filters].nil?
    subnet['vpc_id'] = resource[:vpc_id] unless resource[:vpc_id].nil?
    subnet['ipv6_cidr_block'] = resource[:ipv6_cidr_block] unless resource[:ipv6_cidr_block].nil?
    subnet['subnet_id'] = resource[:subnet_id] unless resource[:subnet_id].nil?
    subnet['subnet_ids'] = resource[:subnet_ids] unless resource[:subnet_ids].nil?
    subnet['vpc_id'] = resource[:vpc_id] unless resource[:vpc_id].nil?
    subnet
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
    client.delete_subnet(namevar => myhash[namevar])
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
