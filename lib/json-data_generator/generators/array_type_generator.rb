module JSON
  class DataGenerator
    class ArrayTypeGenerator < TypeGenerator

      attr_accessor :items
      attr_accessor :minItems, :maxItems

      def initialize(current_node = {}, name = nil)
        super
        raise JSON::ParserError.new("missing items for array") if current_node['items'].nil?
        elem = TypeGenerator::create_generator(current_node['items'])
        elem.required = RequiredCharacteristic.new(true)
        self.items = elem

        current_node.each { |element, value|
          case element
            when 'minItems' then
              self.minItems = MinItemsCharacteristic.new(value)
            when 'maxItems' then
              self.maxItems = MaxItemsCharacteristic.new(value)
          end
        }

      end

      def generate
        return nil unless required?

        output = []

        (min_items + rand(max_items+1-min_items)).times { |e|
          val = items.generate
          output << nil if val.nil? && p.is_a?(NullTypeGenerator)
          output << val if !val.nil? && !p.is_a?(NullTypeGenerator)
        }

        required? ? output : nil
      end

      private
      def min_items
        return MinItemsCharacteristic::default unless self.minItems
        self.minItems.value
      end

      def max_items
        return 15 unless self.maxItems #or will be overwritten by maxLength from schema
        self.maxItems.value
      end
    end
  end
end