module JSON
  class DataGenerator
    class NumberTypeGenerator < TypeGenerator

      attr_accessor :minimum, :maximum

      def initialize(current_node = {}, name = nil)
        super
        current_node.each { |element, value|
          case element
            when 'minimum' then
              self.minimum = MinimumCharacteristic.new(value)
            when 'maximum' then
              self.maximum = MaximumCharacteristic.new(value)
          end
        }
      end

      def generate

        return JSON::ParserError.new("min > max #{min} #{max}") if min > max
        val = rand * (max-min) + min
        required? ? val.round(3) : nil
      end

      protected
      def min
        return MinimumCharacteristic::default unless self.minimum
        self.minimum.value
      end

      def max
        return MaximumCharacteristic::default unless self.maximum
        self.maximum.value
      end

    end
  end
end