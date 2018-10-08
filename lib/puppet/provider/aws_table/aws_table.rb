require "pry"
# require "pry-rescue"
require "json"
require "facets"
require "retries"


require "aws-sdk-dynamodb"


Puppet::Type.type(:aws_table).provide(:arm) do
  mk_resource_methods

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @is_create = false
    @is_delete = false
  end
  
  def namevar
    :table_name
  end

  # DynamoDB Properties

  def attribute_definitions=(value)
    Puppet.info("attribute_definitions setter called to change to #{value}")
    @property_flush[:attribute_definitions] = value
  end
  

  def creation_date_time=(value)
    Puppet.info("creation_date_time setter called to change to #{value}")
    @property_flush[:creation_date_time] = value
  end
  

  def global_secondary_indexes=(value)
    Puppet.info("global_secondary_indexes setter called to change to #{value}")
    @property_flush[:global_secondary_indexes] = value
  end
  

  def item_count=(value)
    Puppet.info("item_count setter called to change to #{value}")
    @property_flush[:item_count] = value
  end
  

  def key_schema=(value)
    Puppet.info("key_schema setter called to change to #{value}")
    @property_flush[:key_schema] = value
  end
  

  def latest_stream_arn=(value)
    Puppet.info("latest_stream_arn setter called to change to #{value}")
    @property_flush[:latest_stream_arn] = value
  end
  

  def latest_stream_label=(value)
    Puppet.info("latest_stream_label setter called to change to #{value}")
    @property_flush[:latest_stream_label] = value
  end
  

  def local_secondary_indexes=(value)
    Puppet.info("local_secondary_indexes setter called to change to #{value}")
    @property_flush[:local_secondary_indexes] = value
  end
  

  def provisioned_throughput=(value)
    Puppet.info("provisioned_throughput setter called to change to #{value}")
    @property_flush[:provisioned_throughput] = value
  end
  

  def restore_summary=(value)
    Puppet.info("restore_summary setter called to change to #{value}")
    @property_flush[:restore_summary] = value
  end
  

  def sse_description=(value)
    Puppet.info("sse_description setter called to change to #{value}")
    @property_flush[:sse_description] = value
  end
  

  def sse_specification=(value)
    Puppet.info("sse_specification setter called to change to #{value}")
    @property_flush[:sse_specification] = value
  end
  

  def stream_specification=(value)
    Puppet.info("stream_specification setter called to change to #{value}")
    @property_flush[:stream_specification] = value
  end
  

  def table_arn=(value)
    Puppet.info("table_arn setter called to change to #{value}")
    @property_flush[:table_arn] = value
  end
  

  def table_id=(value)
    Puppet.info("table_id setter called to change to #{value}")
    @property_flush[:table_id] = value
  end
  

  def table_name=(value)
    Puppet.info("table_name setter called to change to #{value}")
    @property_flush[:table_name] = value
  end
  

  def table_size_bytes=(value)
    Puppet.info("table_size_bytes setter called to change to #{value}")
    @property_flush[:table_size_bytes] = value
  end
  

  def table_status=(value)
    Puppet.info("table_status setter called to change to #{value}")
    @property_flush[:table_status] = value
  end
  
def name=(value)
    Puppet.info("name setter called to change to #{value}")
    @property_flush[:name] = value
  end
  
  def self.get_region
    ENV['AWS_REGION'] || 'us-west-2'
  end

  def self.has_name?(hash)
    !hash[:name].nil? && !hash[:name].empty?
  end

  def create
    @is_create = true
    Puppet.info("Entered create for resource #{resource[:name]} of type Instances")
    client = Aws::DynamoDB::Client.new(region: self.class.get_region)
    client.create_table(build_hash)
    @property_hash[:ensure] = :present
  rescue Exception => ex
    Puppet.alert("Exception during create. The state of the resource is unknown.  ex is #{ex} and backtrace is #{ex.backtrace}")
    raise
  end

  def flush
    Puppet.info("Entered flush for resource #{name} of type <no value> - creating ? #{@is_create}, deleting ? #{@is_delete}")
    if @is_create || @is_delete
      return # we've already done the create or delete
    end
    @is_update = true
    hash = build_hash
    Puppet.info("Calling Update on flush")
    @property_hash[:ensure] = :present
    response = []
  end

  def build_hash
    table = {}
    if @is_create || @is_update
      table[:attribute_definitions] = resource[:attribute_definitions] unless resource[:attribute_definitions].nil?
      table[:global_secondary_indexes] = resource[:global_secondary_indexes] unless resource[:global_secondary_indexes].nil?
      table[:key_schema] = resource[:key_schema] unless resource[:key_schema].nil?
      table[:local_secondary_indexes] = resource[:local_secondary_indexes] unless resource[:local_secondary_indexes].nil?
      table[:provisioned_throughput] = resource[:provisioned_throughput] unless resource[:provisioned_throughput].nil?
      table[:sse_specification] = resource[:sse_specification] unless resource[:sse_specification].nil?
      table[:stream_specification] = resource[:stream_specification] unless resource[:stream_specification].nil?
      table[:table_name] = resource[:table_name] unless resource[:table_name].nil?
    end
    return symbolize(table)
  end

  def destroy
    Puppet.info("Entered delete for resource #{resource[:name]}")
    @is_delete = true
    Puppet.info("Calling operation delete_table")
    client = Aws::DynamoDB::Client.new(region: self.class.get_region)
    client.delete_table({namevar => resource[namevar]})
    @property_hash[:ensure] = :absent
  end


  # Shared funcs
  def exists?
    Puppet.info("Parametered Describe for resource #{name} of type <no value>")
    client = Aws::DynamoDB::Client.new(region: self.class.get_region)
    response = client.describe_table({namevar => resource.to_hash[namevar]})
    res = response.respond_to?(:table) ? response.table : response
    @property_hash[:object] = :present
    @property_hash[namevar] = res[namevar]
    @property_hash[:object] = res
    return true
  rescue Exception => ex
    @property_hash[:object] = :absent
    return false

  end

  def property_hash
    @property_hash
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

# this is the end of the ruby class
