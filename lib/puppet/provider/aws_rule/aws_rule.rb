require 'puppet/resource_api'


require 'aws-sdk-elasticloadbalancingv2'






# AwsRule class
class Puppet::Provider::AwsRule::AwsRule
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
            response = client.describe_rules(:listener_arn => listener['listener_arn'])
            response['rules'].each do |rule|
              all_instances << instance_to_hash(rule) if name?(rule)
            end
          end
        end
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    actions = instance.respond_to?(:actions) ? (instance.actions.respond_to?(:to_hash) ? instance.actions.to_hash : instance.actions) : nil
    conditions = instance.respond_to?(:conditions) ? (instance.conditions.respond_to?(:to_hash) ? instance.conditions.to_hash : instance.conditions) : nil
    listener_arn = instance.respond_to?(:listener_arn) ? (instance.listener_arn.respond_to?(:to_hash) ? instance.listener_arn.to_hash : instance.listener_arn) : nil
    page_size = instance.respond_to?(:page_size) ? (instance.page_size.respond_to?(:to_hash) ? instance.page_size.to_hash : instance.page_size) : nil
    priority = instance.respond_to?(:priority) ? (instance.priority.respond_to?(:to_hash) ? instance.priority.to_hash : instance.priority) : nil
    rule_arn = instance.respond_to?(:rule_arn) ? (instance.rule_arn.respond_to?(:to_hash) ? instance.rule_arn.to_hash : instance.rule_arn) : nil
    rule_arns = instance.respond_to?(:rule_arns) ? (instance.rule_arns.respond_to?(:to_hash) ? instance.rule_arns.to_hash : instance.rule_arns) : nil
    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = instance[namevar]
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:actions] = actions unless actions.nil?
    hash[:conditions] = conditions unless conditions.nil?
    hash[:listener_arn] = listener_arn unless listener_arn.nil?
    hash[:page_size] = page_size unless page_size.nil?
    hash[:priority] = priority unless priority.nil?
    hash[:rule_arn] = rule_arn unless rule_arn.nil?
    hash[:rule_arns] = rule_arns unless rule_arns.nil?
    hash
  end

  def namevar
    :rule_arn
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
      client.create_rule(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))
      client = Aws::ElasticLoadBalancingV2::Client.new(region: region)
      client.modify_rule(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    rule = {}
    rule['actions'] = resource[:actions] unless resource[:actions].nil?
    rule['conditions'] = resource[:conditions] unless resource[:conditions].nil?
    rule['listener_arn'] = resource[:listener_arn] unless resource[:listener_arn].nil?
    rule['page_size'] = resource[:page_size] unless resource[:page_size].nil?
    rule['priority'] = resource[:priority] unless resource[:priority].nil?
    rule['rule_arn'] = resource[:rule_arn] unless resource[:rule_arn].nil?
    rule['rule_arns'] = resource[:rule_arns] unless resource[:rule_arns].nil?
    rule
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
    client.delete_rule(namevar => myhash[namevar])
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
