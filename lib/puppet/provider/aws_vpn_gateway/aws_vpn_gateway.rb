require 'puppet/resource_api'


require 'aws-sdk-ec2'






# AwsVpnGateway class
class Puppet::Provider::AwsVpnGateway::AwsVpnGateway
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)
    all_instances = []
    client.describe_vpn_gateways.each do |response|
      response.vpn_gateways.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    amazon_side_asn = instance.respond_to?(:amazon_side_asn) ? (instance.amazon_side_asn.respond_to?(:to_hash) ? instance.amazon_side_asn.to_hash : instance.amazon_side_asn) : nil
    availability_zone = instance.respond_to?(:availability_zone) ? (instance.availability_zone.respond_to?(:to_hash) ? instance.availability_zone.to_hash : instance.availability_zone) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    state = instance.respond_to?(:state) ? (instance.state.respond_to?(:to_hash) ? instance.state.to_hash : instance.state) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    type = instance.respond_to?(:type) ? (instance.type.respond_to?(:to_hash) ? instance.type.to_hash : instance.type) : nil
    vpc_attachments = instance.respond_to?(:vpc_attachments) ? (instance.vpc_attachments.respond_to?(:to_hash) ? instance.vpc_attachments.to_hash : instance.vpc_attachments) : nil
    vpn_gateway_id = instance.respond_to?(:vpn_gateway_id) ? (instance.vpn_gateway_id.respond_to?(:to_hash) ? instance.vpn_gateway_id.to_hash : instance.vpn_gateway_id) : nil
    vpn_gateway_ids = instance.respond_to?(:vpn_gateway_ids) ? (instance.vpn_gateway_ids.respond_to?(:to_hash) ? instance.vpn_gateway_ids.to_hash : instance.vpn_gateway_ids) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:amazon_side_asn] = amazon_side_asn unless amazon_side_asn.nil?
    hash[:availability_zone] = availability_zone unless availability_zone.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:state] = state unless state.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:type] = type unless type.nil?
    hash[:vpc_attachments] = vpc_attachments unless vpc_attachments.nil?
    hash[:vpn_gateway_id] = vpn_gateway_id unless vpn_gateway_id.nil?
    hash[:vpn_gateway_ids] = vpn_gateway_ids unless vpn_gateway_ids.nil?
    hash
  end
  def namevar
    :vpn_gateway_id
  end

  def self.namevar
    :vpn_gateway_id
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
      response = client.create_vpn_gateway(new_hash)
      res = response.respond_to?(:vpn_gateway) ? response.vpn_gateway : response
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
    vpn_gateway = {}
    vpn_gateway['amazon_side_asn'] = resource[:amazon_side_asn] unless resource[:amazon_side_asn].nil?
    vpn_gateway['availability_zone'] = resource[:availability_zone] unless resource[:availability_zone].nil?
    vpn_gateway['dry_run'] = resource[:dry_run] unless resource[:dry_run].nil?
    vpn_gateway['filters'] = resource[:filters] unless resource[:filters].nil?
    vpn_gateway['type'] = resource[:type] unless resource[:type].nil?
    vpn_gateway['vpn_gateway_id'] = resource[:vpn_gateway_id] unless resource[:vpn_gateway_id].nil?
    vpn_gateway['vpn_gateway_ids'] = resource[:vpn_gateway_ids] unless resource[:vpn_gateway_ids].nil?
    vpn_gateway
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
    client.delete_vpn_gateway(namevar => myhash[namevar])
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
