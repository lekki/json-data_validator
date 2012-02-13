module JSON
  class DataGenerator
    class MaximumCharacteristic < Characteristic

      def self.default
        (2**(0.size * 8 -2) -1)
      end

    end
  end
end