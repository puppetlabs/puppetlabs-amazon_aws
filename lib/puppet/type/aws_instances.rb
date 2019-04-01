require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_instances',
  desc: <<-EOSRAPI,

  EOSRAPI
  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'Whether this apt key should be present or absent on the target system.',
    },
    name: {
      type: 'String',
      behaviour: :namevar,
      desc: '',
    },



    additional_info: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    block_device_mappings: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    capacity_reservation_specification: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    client_token: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    cpu_options: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    credit_specification: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    disable_api_termination: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    dry_run: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    ebs_optimized: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    elastic_gpu_specification: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    elastic_inference_accelerators: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    filters: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    hibernation_options: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    iam_instance_profile: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    image_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    instance_ids: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    instance_initiated_shutdown_behavior: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    instance_market_options: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    instance_type: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    ipv6_address_count: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    ipv6_addresses: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    kernel_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    key_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :namevar,
    },
    launch_template: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    license_specifications: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_count: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :parameter,
    },
    max_results: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    min_count: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :parameter,
    },
    monitoring: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    network_interfaces: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    next_token: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    placement: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    private_ip_address: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    ramdisk_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    security_group_ids: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    security_groups: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subnet_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tag_specifications: {
      type: 'Optional[Tuple]',
      desc: '',
      behaviour: :init_only,
    },
    user_data: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    instance_id: {
      desc: '',
      type: 'Optional[String]',
      behaviour: :init_only
    },

  },

  autorequires: {
    file: '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
