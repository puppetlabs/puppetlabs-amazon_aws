#!/opt/puppetlabs/puppet/bin/ruby
require 'puppet'
require 'aws-sdk'

def format_deep_hash(value)
  # Parameter formatting for hash like structures - example: parameter_name="{:item=>[i1,i2];:item2=>stringElement}"
  request_hash = {}
  value.delete!('{}')
  value.split(';').each do |item|
    vals = item.split('=>')
    if vals[1].include? '['
      vals[1].delete!('[]')
      elements = vals[1].split(',')
      vals[0].delete!(':')
      request_hash[vals[0].strip.to_sym] = elements
    else
      vals[0].delete!(':')
      vals[1].delete!("'")
      request_hash[vals[0].strip.to_sym] = vals[1].strip
    end
  end
  request_hash
end

def operation_with_hash(arg_hash)
  call_hash = {}
  arg_hash.each do |k, v|
    key = k.to_sym
    if k.to_s.end_with? 's'
      arr = v.tr('[]', '').split(',')
      requestarray = []
      arr.each do |item|
        if item.include? '{'
          hashed = format_deep_hash(item)
          requestarray << hashed
        elsif item.include? '['
          requestarray << item.delete!('[]')
        else
          requestarray << item
        end
      end
      call_hash[key] = requestarray
    elsif v.include? '{'
      # Allow json type inputs by simple format change - example: parameter_name="{'item1':'value1','item2':[{'elementa':'value2', 'elementb':'value3'}]}"
      test = v.tr('\'', '\"')
      call_hash[key] = valid_json?(test) ? test : format_deep_hash(v)
    else
      call_hash[key] = v
    end
  end
  client = Aws::RDS::Client.new(region: region)
  client.describe_engine_default_cluster_parameters(call_hash)
end

def describe_engine_default_cluster_parameters(*args)
  argstring = args[0]
  argstring.delete('\\')

  arg_hash = JSON.parse(argstring)
  # Remove task name from arguments
  arg_hash.delete('_task')

  client = Aws::RDS::Client.new(region: region)
  response = client.describe_engine_default_cluster_parameters if arg_hash.empty?
  response = operation_with_hash(arg_hash) unless arg_hash.empty?

  response_to_hash(response)
end

def format_to_hash(value)
  # Parameter formatting for hash like structures - example: parameter_name="{:item=>[i1,i2];:item2=>stringElement}"
  request_hash = {}
  msg = value.delete('{}')
  arr = msg.split(';')
  arr.each do |item|
    vals = item.split('=>')
    if vals[1].include? '['
      valarr = []
      elements = vals[1].delete!('[]').split(',')
      elements.each do |e|
        valarr << e
      end
      request_hash[vals[0].delete!(':').strip.to_sym] = valarr
    else
      request_hash[vals[0].delete!(':').strip.to_sym] = vals[1].delete!('\'').strip
    end
  end
  request_hash
end

def response_to_hash(response)
  hashed = {}
  hashed.merge!(response)
end

def region
  ENV['AWS_REGION'] || 'us-west-2'
end

def valid_json?(json)
  JSON.parse(json)
rescue JSON::ParserError
  false
end

def task
  # Get operation parameters from an input JSON
  params = STDIN.read
  result = describe_engine_default_cluster_parameters(params)
  puts JSON.pretty_generate(result)
rescue StandardError => e
  result = {}
  result[:_error] = {
    msg: e.message,
    kind: 'puppetlabs-amazon_aws/error',
    details: { class: e.class.to_s },
  }
  puts result.to_json
  exit 1
end

task
