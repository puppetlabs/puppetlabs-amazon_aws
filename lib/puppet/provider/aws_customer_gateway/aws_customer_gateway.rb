require 'puppet/resource_api'


require 'aws-sdk-ec2'






# AwsCustomerGateway class
class Puppet::Provider::AwsCustomerGateway::AwsCustomerGateway
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)
    all_instances = []
    client.describe_customer_gateways.each do |response|
      response.customer_gateways.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    bgp_asn = instance.respond_to?(:bgp_asn) ? (instance.bgp_asn.respond_to?(:to_hash) ? instance.bgp_asn.to_hash : instance.bgp_asn) : nil
    customer_gateway_id = instance.respond_to?(:customer_gateway_id) ? (instance.customer_gateway_id.respond_to?(:to_hash) ? instance.customer_gateway_id.to_hash : instance.customer_gateway_id) : nil
    customer_gateway_ids = instance.respond_to?(:customer_gateway_ids) ? (instance.customer_gateway_ids.respond_to?(:to_hash) ? instance.customer_gateway_ids.to_hash : instance.customer_gateway_ids) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    ip_address = instance.respond_to?(:ip_address) ? (instance.ip_address.respond_to?(:to_hash) ? instance.ip_address.to_hash : instance.ip_address) : nil
    public_ip = instance.respond_to?(:public_ip) ? (instance.public_ip.respond_to?(:to_hash) ? instance.public_ip.to_hash : instance.public_ip) : nil
    state = instance.respond_to?(:state) ? (instance.state.respond_to?(:to_hash) ? instance.state.to_hash : instance.state) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    type = instance.respond_to?(:type) ? (instance.type.respond_to?(:to_hash) ? instance.type.to_hash : instance.type) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:bgp_asn] = bgp_asn unless bgp_asn.nil?
    hash[:customer_gateway_id] = customer_gateway_id unless customer_gateway_id.nil?
    hash[:customer_gateway_ids] = customer_gateway_ids unless customer_gateway_ids.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:ip_address] = ip_address unless ip_address.nil?
    hash[:public_ip] = public_ip unless public_ip.nil?
    hash[:state] = state unless state.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:type] = type unless type.nil?
    hash
  end
  def namevar
    :customer_gateway_id
  end

  def self.namevar
    :customer_gateway_id
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
      response = client.create_customer_gateway(new_hash)
      res = response.respond_to?(:customer_gateway) ? response.customer_gateway : response
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
    customer_gateway = {}
    customer_gateway['bgp_asn'] = resource[:bgp_asn] unless resource[:bgp_asn].nil?
    customer_gateway['customer_gateway_id'] = resource[:customer_gateway_id] unless resource[:customer_gateway_id].nil?
    customer_gateway['customer_gateway_ids'] = resource[:customer_gateway_ids] unless resource[:customer_gateway_ids].nil?
    customer_gateway['dry_run'] = resource[:dry_run] unless resource[:dry_run].nil?
    customer_gateway['filters'] = resource[:filters] unless resource[:filters].nil?
    customer_gateway['public_ip'] = resource[:public_ip] unless resource[:public_ip].nil?
    customer_gateway['type'] = resource[:type] unless resource[:type].nil?
    customer_gateway
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
    client.delete_customer_gateway(namevar => myhash[namevar])
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
