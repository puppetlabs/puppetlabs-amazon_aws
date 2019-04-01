require 'puppet/resource_api'


require 'aws-sdk-ec2'






# AwsInternetGateway class
class Puppet::Provider::AwsInternetGateway::AwsInternetGateway
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)
    all_instances = []
    client.describe_internet_gateways.each do |response|
      response.internet_gateways.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    attachments = instance.respond_to?(:attachments) ? (instance.attachments.respond_to?(:to_hash) ? instance.attachments.to_hash : instance.attachments) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    internet_gateway_id = instance.respond_to?(:internet_gateway_id) ? (instance.internet_gateway_id.respond_to?(:to_hash) ? instance.internet_gateway_id.to_hash : instance.internet_gateway_id) : nil
    internet_gateway_ids = instance.respond_to?(:internet_gateway_ids) ? (instance.internet_gateway_ids.respond_to?(:to_hash) ? instance.internet_gateway_ids.to_hash : instance.internet_gateway_ids) : nil
    max_results = instance.respond_to?(:max_results) ? (instance.max_results.respond_to?(:to_hash) ? instance.max_results.to_hash : instance.max_results) : nil
    next_token = instance.respond_to?(:next_token) ? (instance.next_token.respond_to?(:to_hash) ? instance.next_token.to_hash : instance.next_token) : nil
    owner_id = instance.respond_to?(:owner_id) ? (instance.owner_id.respond_to?(:to_hash) ? instance.owner_id.to_hash : instance.owner_id) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:attachments] = attachments unless attachments.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:internet_gateway_id] = internet_gateway_id unless internet_gateway_id.nil?
    hash[:internet_gateway_ids] = internet_gateway_ids unless internet_gateway_ids.nil?
    hash[:max_results] = max_results unless max_results.nil?
    hash[:next_token] = next_token unless next_token.nil?
    hash[:owner_id] = owner_id unless owner_id.nil?
    hash[:tags] = tags unless tags.nil?
    hash
  end
  def namevar
    :internet_gateway_id
  end

  def self.namevar
    :internet_gateway_id
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
      response = client.create_internet_gateway(new_hash)
      res = response.respond_to?(:internet_gateway) ? response.internet_gateway : response
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
    internet_gateway = {}
    internet_gateway['dry_run'] = resource[:dry_run] unless resource[:dry_run].nil?
    internet_gateway['filters'] = resource[:filters] unless resource[:filters].nil?
    internet_gateway['internet_gateway_id'] = resource[:internet_gateway_id] unless resource[:internet_gateway_id].nil?
    internet_gateway['internet_gateway_ids'] = resource[:internet_gateway_ids] unless resource[:internet_gateway_ids].nil?
    internet_gateway['max_results'] = resource[:max_results] unless resource[:max_results].nil?
    internet_gateway['next_token'] = resource[:next_token] unless resource[:next_token].nil?
    internet_gateway
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
    client.delete_internet_gateway(namevar => myhash[namevar])
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
