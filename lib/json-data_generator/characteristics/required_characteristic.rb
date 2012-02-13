module JSON
  class DataGenerator
    class RequiredCharacteristic < Characteristic

      def initialize(default = false)
        self.value = default
      end

      def self.default
        false
      end

    end
  end
end