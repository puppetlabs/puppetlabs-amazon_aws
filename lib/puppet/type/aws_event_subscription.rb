require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'aws_event_subscription',
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



    customer_aws_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    cust_subscription_id: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    enabled: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    event_categories: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    event_categories_list: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    event_subscription_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    filters: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    max_records: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    sns_topic_arn: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    source_ids: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    source_ids_list: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    source_type: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    status: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subscription_creation_time: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    subscription_name: {
      type: 'Optional[String]',
      desc: '',
      behaviour: :init_only,
    },
    tags: {
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
