module JSON
  class DataGenerator
    class NullTypeGenerator < TypeGenerator

      def generate
        required? ? nil : ""
      end

    end
  end
end