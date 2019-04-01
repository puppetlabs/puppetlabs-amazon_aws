require 'puppet/resource_api'


require 'aws-sdk-ec2'






# AwsNetworkInterface class
class Puppet::Provider::AwsNetworkInterface::AwsNetworkInterface
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)
    all_instances = []
    client.describe_network_interfaces.each do |response|
      response.network_interfaces.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    association = instance.respond_to?(:association) ? (instance.association.respond_to?(:to_hash) ? instance.association.to_hash : instance.association) : nil
    attachment = instance.respond_to?(:attachment) ? (instance.attachment.respond_to?(:to_hash) ? instance.attachment.to_hash : instance.attachment) : nil
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone) : nil
    description = instance.respond_to?(:description) ? (instance.description.respond_to?(:to_hash) ? instance.description.to_hash : instance.description) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    groups = instance.respond_to?(:groups) ? (instance.groups.respond_to?(:to_hash) ? instance.groups.to_hash : instance.groups) : nil
    interface_type = instance.respond_to?(:interface_type) ? (instance.interface_type.respond_to?(:to_hash) ? instance.interface_type.to_hash : instance.interface_type) : nil
    ipv6_address_count = instance.respond_to?(:ipv6_address_count) ? (instance.ipv6_address_count.respond_to?(:to_hash) ? instance.ipv6_address_count.to_hash : instance.ipv6_address_count) : nil
    ipv6_addresses = instance.respond_to?(:ipv6_addresses) ? (instance.ipv6_addresses.respond_to?(:to_hash) ? instance.ipv6_addresses.to_hash : instance.ipv6_addresses) : nil
    mac_address = instance.respond_to?(:mac_address) ? (instance.mac_address.respond_to?(:to_hash) ? instance.mac_address.to_hash : instance.mac_address) : nil
    max_results = instance.respond_to?(:max_results) ? (instance.max_results.respond_to?(:to_hash) ? instance.max_results.to_hash : instance.max_results) : nil
    network_interface_id = instance.respond_to?(:network_interface_id) ? (instance.network_interface_id.respond_to?(:to_hash) ? instance.network_interface_id.to_hash : instance.network_interface_id) : nil
    network_interface_ids = instance.respond_to?(:network_interface_ids) ? (instance.network_interface_ids.respond_to?(:to_hash) ? instance.network_interface_ids.to_hash : instance.network_interface_ids) : nil
    next_token = instance.respond_to?(:next_token) ? (instance.next_token.respond_to?(:to_hash) ? instance.next_token.to_hash : instance.next_token) : nil
    owner_id = instance.respond_to?(:owner_id) ? (instance.owner_id.respond_to?(:to_hash) ? instance.owner_id.to_hash : instance.owner_id) : nil
    private_dns_name = instance.respond_to?(:private_dns_name) ? (instance.private_dns_name.respond_to?(:to_hash) ? instance.private_dns_name.to_hash : instance.private_dns_name) : nil
    private_ip_address = instance.respond_to?(:private_ip_address) ? (instance.private_ip_address.respond_to?(:to_hash) ? instance.private_ip_address.to_hash : instance.private_ip_address) : nil
    private_ip_addresses = instance.respond_to?(:private_ip_addresses) ? (instance.private_ip_addresses.respond_to?(:to_hash) ? instance.private_ip_addresses.to_hash : instance.private_ip_addresses) : nil
    requester_id = instance.respond_to?(:requester_id) ? (instance.requester_id.respond_to?(:to_hash) ? instance.requester_id.to_hash : instance.requester_id) : nil
    requester_managed = instance.respond_to?(:requester_managed) ? (instance.requester_managed.respond_to?(:to_hash) ? instance.requester_managed.to_hash : instance.requester_managed) : nil
    secondary_private_ip_address_count = instance.respond_to?(:secondary_private_ip_address_count) ? (instance.secondary_private_ip_address_count.respond_to?(:to_hash) ? instance.secondary_private_ip_address_count.to_hash : instance.secondary_private_ip_address_count) : nil
    source_dest_check = instance.respond_to?(:source_dest_check) ? (instance.source_dest_check.respond_to?(:to_hash) ? instance.source_dest_check.to_hash : instance.source_dest_check) : nil
    status = instance.respond_to?(:status) ? (instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status) : nil
    subnet_id = instance.respond_to?(:subnet_id) ? (instance.subnet_id.respond_to?(:to_hash) ? instance.subnet_id.to_hash : instance.subnet_id) : nil
    tag_set = instance.respond_to?(:tag_set) ? (instance.tag_set.respond_to?(:to_hash) ? instance.tag_set.to_hash : instance.tag_set) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:association] = association unless association.nil?
    hash[:attachment] = attachment unless attachment.nil?
    hash[:availability_zone] = availability_zone unless availability_zone.nil?
    hash[:description] = description unless description.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:groups] = groups unless groups.nil?
    hash[:interface_type] = interface_type unless interface_type.nil?
    hash[:ipv6_address_count] = ipv6_address_count unless ipv6_address_count.nil?
    hash[:ipv6_addresses] = ipv6_addresses unless ipv6_addresses.nil?
    hash[:mac_address] = mac_address unless mac_address.nil?
    hash[:max_results] = max_results unless max_results.nil?
    hash[:network_interface_id] = network_interface_id unless network_interface_id.nil?
    hash[:network_interface_ids] = network_interface_ids unless network_interface_ids.nil?
    hash[:next_token] = next_token unless next_token.nil?
    hash[:owner_id] = owner_id unless owner_id.nil?
    hash[:private_dns_name] = private_dns_name unless private_dns_name.nil?
    hash[:private_ip_address] = private_ip_address unless private_ip_address.nil?
    hash[:private_ip_addresses] = private_ip_addresses unless private_ip_addresses.nil?
    hash[:requester_id] = requester_id unless requester_id.nil?
    hash[:requester_managed] = requester_managed unless requester_managed.nil?
    hash[:secondary_private_ip_address_count] = secondary_private_ip_address_count unless secondary_private_ip_address_count.nil?
    hash[:source_dest_check] = source_dest_check unless source_dest_check.nil?
    hash[:status] = status unless status.nil?
    hash[:subnet_id] = subnet_id unless subnet_id.nil?
    hash[:tag_set] = tag_set unless tag_set.nil?
    hash[:vpc_id] = vpc_id unless vpc_id.nil?
    hash
  end
  def namevar
    :network_interface_id
  end

  def self.namevar
    :network_interface_id
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
      response = client.create_network_interface(new_hash)
      res = response.respond_to?(:network_interface) ? response.network_interface : response
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
    network_interface = {}
    network_interface['description'] = resource[:description] unless resource[:description].nil?
    network_interface['dry_run'] = resource[:dry_run] unless resource[:dry_run].nil?
    network_interface['filters'] = resource[:filters] unless resource[:filters].nil?
    network_interface['groups'] = resource[:groups] unless resource[:groups].nil?
    network_interface['subnet_id'] = resource[:subnet_id] unless resource[:subnet_id].nil?
    network_interface['ipv6_address_count'] = resource[:ipv6_address_count] unless resource[:ipv6_address_count].nil?
    network_interface['ipv6_addresses'] = resource[:ipv6_addresses] unless resource[:ipv6_addresses].nil?
    network_interface['max_results'] = resource[:max_results] unless resource[:max_results].nil?
    network_interface['network_interface_id'] = resource[:network_interface_id] unless resource[:network_interface_id].nil?
    network_interface['network_interface_ids'] = resource[:network_interface_ids] unless resource[:network_interface_ids].nil?
    network_interface['next_token'] = resource[:next_token] unless resource[:next_token].nil?
    network_interface['private_ip_address'] = resource[:private_ip_address] unless resource[:private_ip_address].nil?
    network_interface['private_ip_addresses'] = resource[:private_ip_addresses] unless resource[:private_ip_addresses].nil?
    network_interface['secondary_private_ip_address_count'] = resource[:secondary_private_ip_address_count] unless resource[:secondary_private_ip_address_count].nil?
    network_interface['subnet_id'] = resource[:subnet_id] unless resource[:subnet_id].nil?
    network_interface
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
    client.delete_network_interface(namevar => myhash[namevar])
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
