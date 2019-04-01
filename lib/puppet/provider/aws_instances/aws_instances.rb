require 'puppet/resource_api'


require 'aws-sdk-ec2'






# AwsInstances class
class Puppet::Provider::AwsInstances::AwsInstances
  def canonicalize(_context, _resources)
    # nout to do here but seems we need to implement it
    resources
  end
  def get(context)

    Puppet.debug("Calling instances for region #{region}")
    client = Aws::EC2::Client.new(region: region)
    all_instances = []
    client.describe_instances(
      filters: [{
        name: 'instance-state-name',
        values: ['pending', 'running', 'stopping', 'stopped'],
      }],
    ).each do |response|
      response.reservations.each do |r|
        r.instances.each do |i|
          hash = instance_to_hash(i)
          all_instances << hash if name?(hash)
        end
      end
    end
    @property_hash = all_instances
    context.debug("Completed get, returning hash #{all_instances}")
    all_instances
  end

  def instance_to_hash(instance)
    additional_info = instance.respond_to?(:additional_info) ? (instance.additional_info.respond_to?(:to_hash) ? instance.additional_info.to_hash : instance.additional_info) : nil
    block_device_mappings = instance.respond_to?(:block_device_mappings) ? (instance.block_device_mappings.respond_to?(:to_hash) ? instance.block_device_mappings.to_hash : instance.block_device_mappings) : nil
    capacity_reservation_specification = instance.respond_to?(:capacity_reservation_specification) ? (instance.capacity_reservation_specification.respond_to?(:to_hash) ? instance.capacity_reservation_specification.to_hash : instance.capacity_reservation_specification) : nil
    client_token = instance.respond_to?(:client_token) ? (instance.client_token.respond_to?(:to_hash) ? instance.client_token.to_hash : instance.client_token) : nil
    cpu_options = instance.respond_to?(:cpu_options) ? (instance.cpu_options.respond_to?(:to_hash) ? instance.cpu_options.to_hash : instance.cpu_options) : nil
    credit_specification = instance.respond_to?(:credit_specification) ? (instance.credit_specification.respond_to?(:to_hash) ? instance.credit_specification.to_hash : instance.credit_specification) : nil
    disable_api_termination = instance.respond_to?(:disable_api_termination) ? (instance.disable_api_termination.respond_to?(:to_hash) ? instance.disable_api_termination.to_hash : instance.disable_api_termination) : nil
    dry_run = instance.respond_to?(:dry_run) ? (instance.dry_run.respond_to?(:to_hash) ? instance.dry_run.to_hash : instance.dry_run) : nil
    ebs_optimized = instance.respond_to?(:ebs_optimized) ? (instance.ebs_optimized.respond_to?(:to_hash) ? instance.ebs_optimized.to_hash : instance.ebs_optimized) : nil
    elastic_gpu_specification = instance.respond_to?(:elastic_gpu_specification) ? (instance.elastic_gpu_specification.respond_to?(:to_hash) ? instance.elastic_gpu_specification.to_hash : instance.elastic_gpu_specification) : nil
    elastic_inference_accelerators = instance.respond_to?(:elastic_inference_accelerators) ? (instance.elastic_inference_accelerators.respond_to?(:to_hash) ? instance.elastic_inference_accelerators.to_hash : instance.elastic_inference_accelerators) : nil
    filters = instance.respond_to?(:filters) ? (instance.filters.respond_to?(:to_hash) ? instance.filters.to_hash : instance.filters) : nil
    hibernation_options = instance.respond_to?(:hibernation_options) ? (instance.hibernation_options.respond_to?(:to_hash) ? instance.hibernation_options.to_hash : instance.hibernation_options) : nil
    iam_instance_profile = instance.respond_to?(:iam_instance_profile) ? (instance.iam_instance_profile.respond_to?(:to_hash) ? instance.iam_instance_profile.to_hash : instance.iam_instance_profile) : nil
    image_id = instance.respond_to?(:image_id) ? (instance.image_id.respond_to?(:to_hash) ? instance.image_id.to_hash : instance.image_id) : nil
    instance_ids = instance.respond_to?(:instance_ids) ? (instance.instance_ids.respond_to?(:to_hash) ? instance.instance_ids.to_hash : instance.instance_ids) : nil
    instance_initiated_shutdown_behavior = instance.respond_to?(:instance_initiated_shutdown_behavior) ? (instance.instance_initiated_shutdown_behavior.respond_to?(:to_hash) ? instance.instance_initiated_shutdown_behavior.to_hash : instance.instance_initiated_shutdown_behavior) : nil
    instance_market_options = instance.respond_to?(:instance_market_options) ? (instance.instance_market_options.respond_to?(:to_hash) ? instance.instance_market_options.to_hash : instance.instance_market_options) : nil
    instance_type = instance.respond_to?(:instance_type) ? (instance.instance_type.respond_to?(:to_hash) ? instance.instance_type.to_hash : instance.instance_type) : nil
    ipv6_address_count = instance.respond_to?(:ipv6_address_count) ? (instance.ipv6_address_count.respond_to?(:to_hash) ? instance.ipv6_address_count.to_hash : instance.ipv6_address_count) : nil
    ipv6_addresses = instance.respond_to?(:ipv6_addresses) ? (instance.ipv6_addresses.respond_to?(:to_hash) ? instance.ipv6_addresses.to_hash : instance.ipv6_addresses) : nil
    kernel_id = instance.respond_to?(:kernel_id) ? (instance.kernel_id.respond_to?(:to_hash) ? instance.kernel_id.to_hash : instance.kernel_id) : nil
    key_name = instance.respond_to?(:key_name) ? (instance.key_name.respond_to?(:to_hash) ? instance.key_name.to_hash : instance.key_name) : nil
    launch_template = instance.respond_to?(:launch_template) ? (instance.launch_template.respond_to?(:to_hash) ? instance.launch_template.to_hash : instance.launch_template) : nil
    license_specifications = instance.respond_to?(:license_specifications) ? (instance.license_specifications.respond_to?(:to_hash) ? instance.license_specifications.to_hash : instance.license_specifications) : nil
    max_count = instance.respond_to?(:max_count) ? (instance.max_count.respond_to?(:to_hash) ? instance.max_count.to_hash : instance.max_count) : nil
    max_results = instance.respond_to?(:max_results) ? (instance.max_results.respond_to?(:to_hash) ? instance.max_results.to_hash : instance.max_results) : nil
    min_count = instance.respond_to?(:min_count) ? (instance.min_count.respond_to?(:to_hash) ? instance.min_count.to_hash : instance.min_count) : nil
    monitoring = instance.respond_to?(:monitoring) ? (instance.monitoring.respond_to?(:to_hash) ? instance.monitoring.to_hash : instance.monitoring) : nil
    network_interfaces = instance.respond_to?(:network_interfaces) ? (instance.network_interfaces.respond_to?(:to_hash) ? instance.network_interfaces.to_hash : instance.network_interfaces) : nil
    next_token = instance.respond_to?(:next_token) ? (instance.next_token.respond_to?(:to_hash) ? instance.next_token.to_hash : instance.next_token) : nil
    placement = instance.respond_to?(:placement) ? (instance.placement.respond_to?(:to_hash) ? instance.placement.to_hash : instance.placement) : nil
    private_ip_address = instance.respond_to?(:private_ip_address) ? (instance.private_ip_address.respond_to?(:to_hash) ? instance.private_ip_address.to_hash : instance.private_ip_address) : nil
    ramdisk_id = instance.respond_to?(:ramdisk_id) ? (instance.ramdisk_id.respond_to?(:to_hash) ? instance.ramdisk_id.to_hash : instance.ramdisk_id) : nil
    security_group_ids = instance.respond_to?(:security_group_ids) ? (instance.security_group_ids.respond_to?(:to_hash) ? instance.security_group_ids.to_hash : instance.security_group_ids) : nil
    security_groups = instance.respond_to?(:security_groups) ? (instance.security_groups.respond_to?(:to_hash) ? instance.security_groups.to_hash : instance.security_groups) : nil
    subnet_id = instance.respond_to?(:subnet_id) ? (instance.subnet_id.respond_to?(:to_hash) ? instance.subnet_id.to_hash : instance.subnet_id) : nil
    tag_specifications = instance.respond_to?(:tag_specifications) ? (instance.tag_specifications.respond_to?(:to_hash) ? instance.tag_specifications.to_hash : instance.tag_specifications) : nil
    user_data = instance.respond_to?(:user_data) ? (instance.user_data.respond_to?(:to_hash) ? instance.user_data.to_hash : instance.user_data) : nil

    hash = {}
    hash[:ensure] = :present
    hash[:object] = instance
    hash[:name] = name_from_tag(instance)
    hash[:tags] = instance.tags if instance.respond_to?(:tags) && !instance.tags.empty?
    hash[:tag_set] = instance.tag_set if instance.respond_to?(:tag_set) && !instance.tag_set.empty?

    hash[:additional_info] = additional_info unless additional_info.nil?
    hash[:block_device_mappings] = block_device_mappings unless block_device_mappings.nil?
    hash[:capacity_reservation_specification] = capacity_reservation_specification unless capacity_reservation_specification.nil?
    hash[:client_token] = client_token unless client_token.nil?
    hash[:cpu_options] = cpu_options unless cpu_options.nil?
    hash[:credit_specification] = credit_specification unless credit_specification.nil?
    hash[:disable_api_termination] = disable_api_termination unless disable_api_termination.nil?
    hash[:dry_run] = dry_run unless dry_run.nil?
    hash[:ebs_optimized] = ebs_optimized unless ebs_optimized.nil?
    hash[:elastic_gpu_specification] = elastic_gpu_specification unless elastic_gpu_specification.nil?
    hash[:elastic_inference_accelerators] = elastic_inference_accelerators unless elastic_inference_accelerators.nil?
    hash[:filters] = filters unless filters.nil?
    hash[:hibernation_options] = hibernation_options unless hibernation_options.nil?
    hash[:iam_instance_profile] = iam_instance_profile unless iam_instance_profile.nil?
    hash[:image_id] = image_id unless image_id.nil?
    hash[:instance_ids] = instance_ids unless instance_ids.nil?
    hash[:instance_initiated_shutdown_behavior] = instance_initiated_shutdown_behavior unless instance_initiated_shutdown_behavior.nil?
    hash[:instance_market_options] = instance_market_options unless instance_market_options.nil?
    hash[:instance_type] = instance_type unless instance_type.nil?
    hash[:ipv6_address_count] = ipv6_address_count unless ipv6_address_count.nil?
    hash[:ipv6_addresses] = ipv6_addresses unless ipv6_addresses.nil?
    hash[:kernel_id] = kernel_id unless kernel_id.nil?
    hash[:key_name] = key_name unless key_name.nil?
    hash[:launch_template] = launch_template unless launch_template.nil?
    hash[:license_specifications] = license_specifications unless license_specifications.nil?
    hash[:max_count] = max_count unless max_count.nil?
    hash[:max_results] = max_results unless max_results.nil?
    hash[:min_count] = min_count unless min_count.nil?
    hash[:monitoring] = monitoring unless monitoring.nil?
    hash[:network_interfaces] = network_interfaces unless network_interfaces.nil?
    hash[:next_token] = next_token unless next_token.nil?
    hash[:placement] = placement unless placement.nil?
    hash[:private_ip_address] = private_ip_address unless private_ip_address.nil?
    hash[:ramdisk_id] = ramdisk_id unless ramdisk_id.nil?
    hash[:security_group_ids] = security_group_ids unless security_group_ids.nil?
    hash[:security_groups] = security_groups unless security_groups.nil?
    hash[:subnet_id] = subnet_id unless subnet_id.nil?
    hash[:tag_specifications] = tag_specifications unless tag_specifications.nil?
    hash[:user_data] = user_data unless user_data.nil?
    hash
  end
  def namevar
    :instance_ids
  end

  def self.namevar
    :instance_ids
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
      response = client.run_instances(new_hash)
      ids = []
      response.instances.each do |r|
        ids.push(r.instance_id)
      end
      client.create_tags(
        resources: ids,
        tags: [
          {
            key: 'Name',
            value: name,
          },
          {
            key: 'lifetime',
            value: '1w',
          },
        ],
      )
    end
  rescue StandardError => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end



  def build_hash(resource)
    instances = {}
    instances['additional_info'] = resource[:additional_info] unless resource[:additional_info].nil?
    instances['block_device_mappings'] = resource[:block_device_mappings] unless resource[:block_device_mappings].nil?
    instances['capacity_reservation_specification'] = resource[:capacity_reservation_specification] unless resource[:capacity_reservation_specification].nil?
    instances['client_token'] = resource[:client_token] unless resource[:client_token].nil?
    instances['cpu_options'] = resource[:cpu_options] unless resource[:cpu_options].nil?
    instances['credit_specification'] = resource[:credit_specification] unless resource[:credit_specification].nil?
    instances['disable_api_termination'] = resource[:disable_api_termination] unless resource[:disable_api_termination].nil?
    instances['dry_run'] = resource[:dry_run] unless resource[:dry_run].nil?
    instances['ebs_optimized'] = resource[:ebs_optimized] unless resource[:ebs_optimized].nil?
    instances['elastic_gpu_specification'] = resource[:elastic_gpu_specification] unless resource[:elastic_gpu_specification].nil?
    instances['elastic_inference_accelerators'] = resource[:elastic_inference_accelerators] unless resource[:elastic_inference_accelerators].nil?
    instances['filters'] = resource[:filters] unless resource[:filters].nil?
    instances['hibernation_options'] = resource[:hibernation_options] unless resource[:hibernation_options].nil?
    instances['iam_instance_profile'] = resource[:iam_instance_profile] unless resource[:iam_instance_profile].nil?
    instances['kernel_id'] = resource[:kernel_id] unless resource[:kernel_id].nil?
    instances['image_id'] = resource[:image_id] unless resource[:image_id].nil?
    instances['instance_ids'] = resource[:instance_ids] unless resource[:instance_ids].nil?
    instances['instance_initiated_shutdown_behavior'] = resource[:instance_initiated_shutdown_behavior] unless resource[:instance_initiated_shutdown_behavior].nil?
    instances['instance_market_options'] = resource[:instance_market_options] unless resource[:instance_market_options].nil?
    instances['instance_type'] = resource[:instance_type] unless resource[:instance_type].nil?
    instances['ipv6_address_count'] = resource[:ipv6_address_count] unless resource[:ipv6_address_count].nil?
    instances['ipv6_addresses'] = resource[:ipv6_addresses] unless resource[:ipv6_addresses].nil?
    instances['kernel_id'] = resource[:kernel_id] unless resource[:kernel_id].nil?
    instances['key_name'] = resource[:key_name] unless resource[:key_name].nil?
    instances['launch_template'] = resource[:launch_template] unless resource[:launch_template].nil?
    instances['license_specifications'] = resource[:license_specifications] unless resource[:license_specifications].nil?
    instances['max_count'] = resource[:max_count] unless resource[:max_count].nil?
    instances['max_results'] = resource[:max_results] unless resource[:max_results].nil?
    instances['min_count'] = resource[:min_count] unless resource[:min_count].nil?
    instances['monitoring'] = resource[:monitoring] unless resource[:monitoring].nil?
    instances['network_interfaces'] = resource[:network_interfaces] unless resource[:network_interfaces].nil?
    instances['next_token'] = resource[:next_token] unless resource[:next_token].nil?
    instances['placement'] = resource[:placement] unless resource[:placement].nil?
    instances['private_ip_address'] = resource[:private_ip_address] unless resource[:private_ip_address].nil?
    instances['ramdisk_id'] = resource[:ramdisk_id] unless resource[:ramdisk_id].nil?
    instances['security_group_ids'] = resource[:security_group_ids] unless resource[:security_group_ids].nil?
    instances['security_groups'] = resource[:security_groups] unless resource[:security_groups].nil?
    instances['subnet_id'] = resource[:subnet_id] unless resource[:subnet_id].nil?
    instances['tag_specifications'] = resource[:tag_specifications] unless resource[:tag_specifications].nil?
    instances['user_data'] = resource[:user_data] unless resource[:user_data].nil?
    instances
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
    deleteable_instance_ids = []
    client.describe_instances(
      filters: [{
        name: 'instance-state-name',
        values: ['pending', 'running', 'stopping', 'stopped'],
      }],
    ).each do |response|
      response.reservations.each do |r|
        r.instances.each do |i|
          instance_name = name_from_tag(i)
          if should[:name] == instance_name
            deleteable_instance_ids << i.instance_id
          end
        end
      end
    end
    client.terminate_instances(instance_ids: deleteable_instance_ids)
    client.wait_until(:instance_terminated, instance_ids: deleteable_instance_ids)
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
