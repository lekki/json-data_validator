$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/json-data_generator"

require 'json'
require 'json-schema'

require File.join(File.dirname(__FILE__), "json-data_generator/generators/type_generator.rb")
require File.join(File.dirname(__FILE__), "json-data_generator/generators/number_type_generator.rb")

Dir[File.join(File.dirname(__FILE__), "json-data_generator/characteristics/*.rb")].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), "json-data_generator/generators/*.rb")].each { |file| require file }


module JSON
  class DataGenerator

    attr_accessor :schema

    def initialize(json_schema)
      raise ArgumentError.new("json schema not provided") if json_schema.nil? || json_schema.empty?
      self.schema = File.open(json_schema, "rb") { |f| JSON.parse(f.read) }
    end

    def generate

      raise JSON::ParserError.new('schema is invalid') if self.schema.key?('type').nil?
      raise NotImplementedError.new("parent must be object type") unless self.schema['type'] || self.schema['type'] == "object"

      result = ObjectTypeGenerator.new(schema).generate
      JSON::Validator.validate!(schema, result, :validate_schema => true)
      result
    end
  end
end

p JSON::DataGenerator.new("test/schema2.json").generate
