module JSON
  class DataGenerator
    class IntegerTypeGenerator < NumberTypeGenerator
      def initialize(current_node = {}, name = nil)
        super
      end

      def generate
        return JSON::ParserError.new("min > max #{min} #{max}") if min > max
        val = min + rand(max - min)
        required? ? val : nil
      end

    end

  end
end