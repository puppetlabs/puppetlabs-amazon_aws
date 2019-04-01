require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_network_interface',
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



    association: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    attachment: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    availability_zone: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    description: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    dry_run: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    filters: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    groups: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    interface_type: {
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
    mac_address: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_results: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    network_interface_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    network_interface_ids: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    next_token: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    owner_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    private_dns_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    private_ip_address: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    private_ip_addresses: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    requester_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    requester_managed: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    secondary_private_ip_address_count: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    source_dest_check: {
      type: 'Optional[Boolean]',
      desc: '',
      behaviour: :init_only,
    },
    status: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subnet_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tag_set: {
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
