module JSON
  class DataGenerator
    class BooleanTypeGenerator < TypeGenerator

      def generate
        required? ? [true, false].sample : nil
      end

    end

  end
end