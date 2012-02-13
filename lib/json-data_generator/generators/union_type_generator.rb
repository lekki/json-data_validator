module JSON
  class DataGenerator
    class UnionTypeGenerator < TypeGenerator

      attr_accessor :types

      def initialize(current_node = {}, name = nil)
        super
        p current_node
        self.types = []
        elem_dup = current_node.dup
        current_node['type'].each { |element|
          elem_dup = current_node.dup
          elem_dup['type'] = element
          self.types << TypeGenerator::create_generator(elem_dup)
        }

        raise JSON::ParserError.new("union should have at least two elements") if self.types.length < 2

      end

      def generate
        return nil unless required?

        type_index = rand(self.types.length)
        type = self.types[type_index]
        val = type.generate
        output = nil if val.nil? && type.is_a?(NullTypeGenerator)
        output = val if !val.nil? && !type.is_a?(NullTypeGenerator)

        required? ? output : nil
      end
    end
  end
end