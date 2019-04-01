require 'puppet/resource_api'


require 'aws-sdk-ec2'






# AwsVpc class
class Puppet::Provider::AwsVpc::AwsVpc
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)
    all_instances = []
    client.describe_vpcs.each do |response|
      response.vpcs.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    amazon_provided_ipv6_cidr_block = instance.respond_to?(:amazon_provided_ipv6_cidr_block) ? (instance.amazon_provided_ipv6_cidr_block.respond_to?(:to_hash) ? instance.amazon_provided_ipv6_cidr_block.to_hash : instance.amazon_provided_ipv6_cidr_block) : nil
    cidr_block = instance.respond_to?(:cidr_block) ? (instance.cidr_block.respond_to?(:to_hash) ? instance.cidr_block.to_hash : instance.cidr_block) : nil
    cidr_block_association_set = instance.respond_to?(:cidr_block_association_set) ? (instance.cidr_block_association_set.respond_to?(:to_hash) ? instance.cidr_block_association_set.to_hash : instance.cidr_block_association_set) : nil
    dhcp_options_id = instance.respond_to?(:dhcp_options_id) ? (instance.dhcp_options_id.respond_to?(:to_hash) ? instance.dhcp_options_id.to_hash : instance.dhcp_options_id) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    instance_tenancy = instance.respond_to?(:instance_tenancy) ? (instance.instance_tenancy.respond_to?(:to_hash) ? instance.instance_tenancy.to_hash : instance.instance_tenancy) : nil
    ipv6_cidr_block_association_set = instance.respond_to?(:ipv6_cidr_block_association_set) ? (instance.ipv6_cidr_block_association_set.respond_to?(:to_hash) ? instance.ipv6_cidr_block_association_set.to_hash : instance.ipv6_cidr_block_association_set) : nil
    is_default = instance.respond_to?(:is_default) ? (instance.is_default.respond_to?(:to_hash) ? instance.is_default.to_hash : instance.is_default) : nil
    max_results = instance.respond_to?(:max_results) ? (instance.max_results.respond_to?(:to_hash) ? instance.max_results.to_hash : instance.max_results) : nil
    next_token = instance.respond_to?(:next_token) ? (instance.next_token.respond_to?(:to_hash) ? instance.next_token.to_hash : instance.next_token) : nil
    owner_id = instance.respond_to?(:owner_id) ? (instance.owner_id.respond_to?(:to_hash) ? instance.owner_id.to_hash : instance.owner_id) : nil
    state = instance.respond_to?(:state) ? (instance.state.respond_to?(:to_hash) ? instance.state.to_hash : instance.state) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    vpc_id = instance.respond_to?(:vpc_id) ? (instance.vpc_id.respond_to?(:to_hash) ? instance.vpc_id.to_hash : instance.vpc_id) : nil
    vpc_ids = instance.respond_to?(:vpc_ids) ? (instance.vpc_ids.respond_to?(:to_hash) ? instance.vpc_ids.to_hash : instance.vpc_ids) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:amazon_provided_ipv6_cidr_block] = amazon_provided_ipv6_cidr_block unless amazon_provided_ipv6_cidr_block.nil?
    hash[:cidr_block] = cidr_block unless cidr_block.nil?
    hash[:cidr_block_association_set] = cidr_block_association_set unless cidr_block_association_set.nil?
    hash[:dhcp_options_id] = dhcp_options_id unless dhcp_options_id.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:instance_tenancy] = instance_tenancy unless instance_tenancy.nil?
    hash[:ipv6_cidr_block_association_set] = ipv6_cidr_block_association_set unless ipv6_cidr_block_association_set.nil?
    hash[:is_default] = is_default unless is_default.nil?
    hash[:max_results] = max_results unless max_results.nil?
    hash[:next_token] = next_token unless next_token.nil?
    hash[:owner_id] = owner_id unless owner_id.nil?
    hash[:state] = state unless state.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:vpc_id] = vpc_id unless vpc_id.nil?
    hash[:vpc_ids] = vpc_ids unless vpc_ids.nil?
    hash
  end
  def namevar
    :vpc_id
  end

  def self.namevar
    :vpc_id
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
      response = client.create_vpc(new_hash)
      res = response.respond_to?(:vpc) ? response.vpc : response
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
    vpc = {}
    vpc['amazon_provided_ipv6_cidr_block'] = resource[:amazon_provided_ipv6_cidr_block] unless resource[:amazon_provided_ipv6_cidr_block].nil?
    vpc['cidr_block'] = resource[:cidr_block] unless resource[:cidr_block].nil?
    vpc['dry_run'] = resource[:dry_run] unless resource[:dry_run].nil?
    vpc['filters'] = resource[:filters] unless resource[:filters].nil?
    vpc['instance_tenancy'] = resource[:instance_tenancy] unless resource[:instance_tenancy].nil?
    vpc['max_results'] = resource[:max_results] unless resource[:max_results].nil?
    vpc['next_token'] = resource[:next_token] unless resource[:next_token].nil?
    vpc['vpc_id'] = resource[:vpc_id] unless resource[:vpc_id].nil?
    vpc['vpc_ids'] = resource[:vpc_ids] unless resource[:vpc_ids].nil?
    vpc
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
    client.delete_vpc(namevar => myhash[namevar])
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
