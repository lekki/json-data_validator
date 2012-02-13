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