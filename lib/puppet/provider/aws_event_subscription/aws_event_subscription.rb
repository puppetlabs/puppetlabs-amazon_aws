require 'puppet/resource_api'


require 'aws-sdk-rds'






# AwsEventSubscription class
class Puppet::Provider::AwsEventSubscription::AwsEventSubscription
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    context.debug('Entered get')
    Puppet.debug("Calling instances for region #{region}")
    client        = Aws::RDS::Client.new(region: region)
    all_instances = []
    client.describe_event_subscriptions.each do |response|
      response.event_subscriptions_list.each do |i|
        hash = instance_to_hash(i)
        all_instances << hash if name?(hash)
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances

  end

  def instance_to_hash(instance)
    customer_aws_id = instance.respond_to?(:customer_aws_id) ? (instance.customer_aws_id.respond_to?(:to_hash) ? instance.customer_aws_id.to_hash : instance.customer_aws_id) : nil
    cust_subscription_id = instance.respond_to?(:cust_subscription_id) ? (instance.cust_subscription_id.respond_to?(:to_hash) ? instance.cust_subscription_id.to_hash : instance.cust_subscription_id) : nil
    enabled = instance.respond_to?(:enabled) ? (instance.enabled.respond_to?(:to_hash) ? instance.enabled.to_hash : instance.enabled) : nil
    event_categories = instance.respond_to?(:event_categories) ? (instance.event_categories.respond_to?(:to_hash) ? instance.event_categories.to_hash : instance.event_categories) : nil
    event_categories_list = instance.respond_to?(:event_categories_list) ? (instance.event_categories_list.respond_to?(:to_hash) ? instance.event_categories_list.to_hash : instance.event_categories_list) : nil
    event_subscription_arn = instance.respond_to?(:event_subscription_arn) ? (instance.event_subscription_arn.respond_to?(:to_hash) ? instance.event_subscription_arn.to_hash : instance.event_subscription_arn) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    max_records = instance.respond_to?(:max_records) ? (instance.max_records.respond_to?(:to_hash) ? instance.max_records.to_hash : instance.max_records) : nil
    sns_topic_arn = instance.respond_to?(:sns_topic_arn) ? (instance.sns_topic_arn.respond_to?(:to_hash) ? instance.sns_topic_arn.to_hash : instance.sns_topic_arn) : nil
    source_ids = instance.respond_to?(:source_ids) ? (instance.source_ids.respond_to?(:to_hash) ? instance.source_ids.to_hash : instance.source_ids) : nil
    source_ids_list = instance.respond_to?(:source_ids_list) ? (instance.source_ids_list.respond_to?(:to_hash) ? instance.source_ids_list.to_hash : instance.source_ids_list) : nil
    source_type = instance.respond_to?(:source_type) ? (instance.source_type.respond_to?(:to_hash) ? instance.source_type.to_hash : instance.source_type) : nil
    status = instance.respond_to?(:status) ? (instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status) : nil
    subscription_creation_time = instance.respond_to?(:subscription_creation_time) ? (instance.subscription_creation_time.respond_to?(:to_hash) ? instance.subscription_creation_time.to_hash : instance.subscription_creation_time) : nil
    subscription_name = instance.respond_to?(:subscription_name) ? (instance.subscription_name.respond_to?(:to_hash) ? instance.subscription_name.to_hash : instance.subscription_name) : nil
    tags = instance.respond_to?(:tags) ? (instance.tags.respond_to?(:to_hash) ? instance.tags.to_hash : instance.tags) : nil

    event_subscription = {}
    event_subscription[:ensure] = :present
    event_subscription[:object] = instance
    event_subscription[:name] = instance.to_hash[:cust_subscription_id]
    event_subscription[:customer_aws_id] = customer_aws_id unless customer_aws_id.nil?
    event_subscription[:cust_subscription_id] = cust_subscription_id unless cust_subscription_id.nil?
    event_subscription[:enabled] = enabled unless enabled.nil?
    event_subscription[:event_categories] = event_categories unless event_categories.nil?
    event_subscription[:event_categories_list] = event_categories_list unless event_categories_list.nil?
    event_subscription[:event_subscription_arn] = event_subscription_arn unless event_subscription_arn.nil?
    event_subscription[:filters] = filters unless filters.nil?
    event_subscription[:max_records] = max_records unless max_records.nil?
    event_subscription[:sns_topic_arn] = sns_topic_arn unless sns_topic_arn.nil?
    event_subscription[:source_ids] = source_ids unless source_ids.nil?
    event_subscription[:source_ids_list] = source_ids_list unless source_ids_list.nil?
    event_subscription[:source_type] = source_type unless source_type.nil?
    event_subscription[:status] = status unless status.nil?
    event_subscription[:subscription_creation_time] = subscription_creation_time unless subscription_creation_time.nil?
    event_subscription[:subscription_name] = subscription_name unless subscription_name.nil?
    event_subscription[:tags] = tags unless tags.nil?
    event_subscription
  end

  def namevar
    :subscription_name
  end

  def self.namevar
    :subscription_name
  end

  def name?(hash)
    !hash[self.namevar].nil? && !hash[self.namevar].empty?
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
        # if update method exists call update, else delete and recreate the resourceupdate(context, name, should)
      end
    end
  end

  def self.region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def create(context, name, should)
    context.creating(name) do
      new_hash = symbolize(build_hash(should))

      client   = Aws::RDS::Client.new(region: region)
      client.create_event_subscription(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def update(context, name, should)
    context.updating(name) do
      new_hash = symbolize(build_hash(should))

      client = Aws::RDS::Client.new(region: region)
      client.modify_event_subscription(new_hash)
    end
  rescue StandardError => ex
    Puppet.alert("Exception during flush. ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end


  def build_hash(resource)
    event_subscription = {}
    event_subscription['enabled'] = resource[:enabled] unless resource[:enabled].nil?
    event_subscription['event_categories'] = resource[:event_categories] unless resource[:event_categories].nil?
    event_subscription['filters'] = resource[:filters] unless resource[:filters].nil?
    event_subscription['max_records'] = resource[:max_records] unless resource[:max_records].nil?
    event_subscription['subscription_name'] = resource[:subscription_name] unless resource[:subscription_name].nil?
    event_subscription['sns_topic_arn'] = resource[:sns_topic_arn] unless resource[:sns_topic_arn].nil?
    event_subscription['source_ids'] = resource[:source_ids] unless resource[:source_ids].nil?
    event_subscription['source_type'] = resource[:source_type] unless resource[:source_type].nil?
    event_subscription['subscription_name'] = resource[:subscription_name] unless resource[:subscription_name].nil?
    event_subscription['tags'] = resource[:tags] unless resource[:tags].nil?
    symbolize(event_subscription)
  end

  def self.build_key_values
    key_values = {}
    key_values
  end

  def destroy
    delete(resource)
  end

  def delete(should)
    new_hash = symbolize(build_hash(should))
    client = Aws::RDS::Client.new(region: region)
    client.delete_event_subscription(new_hash)
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
