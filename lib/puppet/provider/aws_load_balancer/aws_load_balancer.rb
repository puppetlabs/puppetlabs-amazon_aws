require 'puppet/resource_api'


require 'aws-sdk-elasticloadbalancingv2'






# AwsLoadBalancer class
class Puppet::Provider::AwsLoadBalancer::AwsLoadBalancer
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: region)
    all_instances = []
    client.describe_load_balancers.each do |response|
      response.load_balancers.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    ip_address_type = instance.respond_to?(:ip_address_type) ? (instance.ip_address_type.respond_to?(:to_hash) ? instance.ip_address_type.to_hash : instance.ip_address_type) : nil
    load_balancer_arn = instance.respond_to?(:load_balancer_arn) ? (instance.load_balancer_arn.respond_to?(:to_hash) ? instance.load_balancer_arn.to_hash : instance.load_balancer_arn) : nil
    load_balancer_arns = instance.respond_to?(:load_balancer_arns) ? (instance.load_balancer_arns.respond_to?(:to_hash) ? instance.load_balancer_arns.to_hash : instance.load_balancer_arns) : nil
    names = instance.respond_to?(:names) ? (instance.names.respond_to?(:to_hash) ? instance.names.to_hash : instance.names) : nil
    page_size = instance.respond_to?(:page_size) ? (instance.page_size.respond_to?(:to_hash) ? instance.page_size.to_hash : instance.page_size) : nil
    scheme = instance.respond_to?(:scheme) ? (instance.scheme.respond_to?(:to_hash) ? instance.scheme.to_hash : instance.scheme) : nil
    security_groups = instance.respond_to?(:security_groups) ? (instance.security_groups.respond_to?(:to_hash) ? instance.security_groups.to_hash : instance.security_groups) : nil
    subnet_mappings = instance.respond_to?(:subnet_mappings) ? (instance.subnet_mappings.respond_to?(:to_hash) ? instance.subnet_mappings.to_hash : instance.subnet_mappings) : nil
    subnets = instance.respond_to?(:subnets) ? (instance.subnets.respond_to?(:to_hash) ? instance.subnets.to_hash : instance.subnets) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil
    type = instance.respond_to?(:type) ? (instance.type.respond_to?(:to_hash) ? instance.type.to_hash : instance.type) : nil
    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = instance[:load_balancer_name]
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:ip_address_type] = ip_address_type unless ip_address_type.nil?
    hash[:load_balancer_arn] = load_balancer_arn unless load_balancer_arn.nil?
    hash[:load_balancer_arns] = load_balancer_arns unless load_balancer_arns.nil?
    hash[:names] = names unless names.nil?
    hash[:page_size] = page_size unless page_size.nil?
    hash[:scheme] = scheme unless scheme.nil?
    hash[:security_groups] = security_groups unless security_groups.nil?
    hash[:subnet_mappings] = subnet_mappings unless subnet_mappings.nil?
    hash[:subnets] = subnets unless subnets.nil?
    hash[:tags] = tags unless tags.nil?
    hash[:type] = type unless type.nil?
    hash
  end

  def namevar
    :load_balancer_arn
  end

  def name?(hash)
    !hash[namevar].nil? && !hash[namevar].empty?
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
      client = Aws::ElasticLoadBalancingV2::Client.new(region: region)
      client.create_load_balancer(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end



  def build_hash(resource)
    load_balancer = {}
    load_balancer['ip_address_type'] = resource[:ip_address_type] unless resource[:ip_address_type].nil?
    load_balancer['load_balancer_arn'] = resource[:load_balancer_arn] unless resource[:load_balancer_arn].nil?
    load_balancer['load_balancer_arns'] = resource[:load_balancer_arns] unless resource[:load_balancer_arns].nil?
    load_balancer['name'] = resource[:name] unless resource[:name].nil?
    load_balancer['names'] = resource[:names] unless resource[:names].nil?
    load_balancer['page_size'] = resource[:page_size] unless resource[:page_size].nil?
    load_balancer['scheme'] = resource[:scheme] unless resource[:scheme].nil?
    load_balancer['security_groups'] = resource[:security_groups] unless resource[:security_groups].nil?
    load_balancer['subnet_mappings'] = resource[:subnet_mappings] unless resource[:subnet_mappings].nil?
    load_balancer['subnets'] = resource[:subnets] unless resource[:subnets].nil?
    load_balancer['tags'] = resource[:tags] unless resource[:tags].nil?
    load_balancer['type'] = resource[:type] unless resource[:type].nil?
    load_balancer
  end

  def build_key_values
    key_values = {}

    key_values
  end

  def destroy
    delete(resource)
  end

  def delete(should)
    client = Aws::ElasticLoadBalancingV2::Client.new(region: region)
    myhash = {}
    @property_hash.each do |response|
      if name_from_tag(response) == should[:title]
        myhash = response
      end
    end
    client.delete_load_balancer(namevar => myhash[namevar])
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
