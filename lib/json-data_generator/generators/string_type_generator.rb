module JSON
  class DataGenerator
    class StringTypeGenerator < TypeGenerator

      attr_accessor :minLength, :maxLength

      def initialize(current_node = {}, name = nil)
        super
        current_node.each { |element, value|
          case element
            when 'minLength' then
              self.minLength = MinLengthCharacteristic.new(value)
            when 'maxLength' then
              self.maxLength = MaxLengthCharacteristic.new(value)
          end
        }
      end

      def generate

        return JSON::ParserError.new("minLength > maxLength #{min_length} #{max_length}") if min_length > max_length
        val = (min_length + rand(max_length+1-min_length)).times.map { 65.+(rand(25)).chr }.join
        required? ? val : nil
      end

      private
      def min_length
        return MinLengthCharacteristic::default unless self.minLength
        self.minLength.value
      end

      def max_length
        return 20 unless self.maxLength #or will be overwritten by maxLength from schema
        self.maxLength.value
      end

    end
  end
end
