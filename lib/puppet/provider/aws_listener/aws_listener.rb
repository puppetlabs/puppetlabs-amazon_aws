require 'puppet/resource_api'


require 'aws-sdk-elasticloadbalancingv2'






# AwsListener class
class Puppet::Provider::AwsListener::AwsListener
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::ElasticLoadBalancingV2::Client.new(region: region)
    all_instances = []

 client.describe_load_balancers.each do |list|
   list['load_balancers'].each do |balancer|
     client.describe_listeners(:load_balancer_arn => balancer['load_balancer_arn']).each do |listeners|
       listeners['listeners'].each do |listener|
         all_instances << instance_to_hash(listener) if name?(listener)
       end
     end
   end
 end

    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    certificates = instance.respond_to?(:certificates) ? (instance.certificates.respond_to?(:to_hash) ? instance.certificates.to_hash : instance.certificates) : nil
    default_actions = instance.respond_to?(:default_actions) ? (instance.default_actions.respond_to?(:to_hash) ? instance.default_actions.to_hash : instance.default_actions) : nil
    listener_arn = instance.respond_to?(:listener_arn) ? (instance.listener_arn.respond_to?(:to_hash) ? instance.listener_arn.to_hash : instance.listener_arn) : nil
    listener_arns = instance.respond_to?(:listener_arns) ? (instance.listener_arns.respond_to?(:to_hash) ? instance.listener_arns.to_hash : instance.listener_arns) : nil
    load_balancer_arn = instance.respond_to?(:load_balancer_arn) ? (instance.load_balancer_arn.respond_to?(:to_hash) ? instance.load_balancer_arn.to_hash : instance.load_balancer_arn) : nil
    page_size = instance.respond_to?(:page_size) ? (instance.page_size.respond_to?(:to_hash) ? instance.page_size.to_hash : instance.page_size) : nil
    port = instance.respond_to?(:port) ? (instance.port.respond_to?(:to_hash) ? instance.port.to_hash : instance.port) : nil
    protocol = instance.respond_to?(:protocol) ? (instance.protocol.respond_to?(:to_hash) ? instance.protocol.to_hash : instance.protocol) : nil
    ssl_policy = instance.respond_to?(:ssl_policy) ? (instance.ssl_policy.respond_to?(:to_hash) ? instance.ssl_policy.to_hash : instance.ssl_policy) : nil
    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = instance[namevar]
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:certificates] = certificates unless certificates.nil?
    hash[:default_actions] = default_actions unless default_actions.nil?
    hash[:listener_arn] = listener_arn unless listener_arn.nil?
    hash[:listener_arns] = listener_arns unless listener_arns.nil?
    hash[:load_balancer_arn] = load_balancer_arn unless load_balancer_arn.nil?
    hash[:page_size] = page_size unless page_size.nil?
    hash[:port] = port unless port.nil?
    hash[:protocol] = protocol unless protocol.nil?
    hash[:ssl_policy] = ssl_policy unless ssl_policy.nil?
    hash
  end

  def namevar
    :listener_arn
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
      client = Aws::ElasticLoadBalancingV2::Client.new(region: region)
      client.create_listener(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))
      client = Aws::ElasticLoadBalancingV2::Client.new(region: region)
      client.modify_listener(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    listener = {}
    listener['certificates'] = resource[:certificates] unless resource[:certificates].nil?
    listener['default_actions'] = resource[:default_actions] unless resource[:default_actions].nil?
    listener['listener_arn'] = resource[:listener_arn] unless resource[:listener_arn].nil?
    listener['listener_arns'] = resource[:listener_arns] unless resource[:listener_arns].nil?
    listener['load_balancer_arn'] = resource[:load_balancer_arn] unless resource[:load_balancer_arn].nil?
    listener['page_size'] = resource[:page_size] unless resource[:page_size].nil?
    listener['port'] = resource[:port] unless resource[:port].nil?
    listener['protocol'] = resource[:protocol] unless resource[:protocol].nil?
    listener['ssl_policy'] = resource[:ssl_policy] unless resource[:ssl_policy].nil?
    listener
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
      if response[namevar] == should[namevar]
        myhash = response
      end
    end
    client.delete_listener(namevar => myhash[namevar])
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
