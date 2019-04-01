require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_route_table',
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



    associations: {
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
    max_results: {
      type: 'Optional[Integer]',
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
    propagating_vgws: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    routes: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    route_table_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    route_table_ids: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tags: {
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
