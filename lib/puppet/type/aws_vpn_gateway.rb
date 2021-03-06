require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_vpn_gateway',
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



    amazon_side_asn: {
      type: 'Optional[Integer]',
      desc: '',
      behaviour: :init_only,
    },
    availability_zone: {
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
    state: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tags: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    type: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    vpc_attachments: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    vpn_gateway_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    vpn_gateway_ids: {
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
