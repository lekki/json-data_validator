=begin
require "/Users/lekki/json_data_generator/type_generator.rb"
require "/Users/lekki/json_data_generator/integer_type_generator.rb"
require "/Users/lekki/json_data_generator/string_type_generator.rb"
require "/Users/lekki/json_data_generator/null_type_generator.rb"
require "/Users/lekki/json_data_generator/boolean_type_generator.rb"
require "/Users/lekki/json_data_generator/array_type_generator.rb"
require "/Users/lekki/json_data_generator/union_type_generator.rb"
=end
module JSON
  class DataGenerator
    class ObjectTypeGenerator < TypeGenerator

      attr_accessor :properties

      def initialize(current_node = {}, name = nil)
        super
        self.properties = []

        current_node["properties"].each { |property, definition|
          type = TypeGenerator::create_generator(definition, property)
          self.properties << type unless type.nil?
        } unless current_node["properties"].nil?

      end

      def generate
        output = Hash.new

        self.properties.each { |p|
          val = p.generate
          output[p.name] = nil if val.nil? && p.is_a?(NullTypeGenerator)
          output[p.name] = val if !val.nil? && !p.is_a?(NullTypeGenerator)
        }

        required? ? output : ""
      end

    end

  end
end