require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_target_group',
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



    health_check_enabled: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    health_check_interval_seconds: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    health_check_path: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    health_check_port: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    health_check_protocol: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    health_check_timeout_seconds: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    healthy_threshold_count: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    load_balancer_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    matcher: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    names: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    page_size: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    port: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    protocol: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    target_group_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    target_group_arns: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    target_type: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    unhealthy_threshold_count: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    vpc_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },

  },

  autorequires: {
    file: '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
