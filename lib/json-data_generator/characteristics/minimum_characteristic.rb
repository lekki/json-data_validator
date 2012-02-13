module JSON
  class DataGenerator
    class MinimumCharacteristic < Characteristic


      def self.default
        -(2**(0.size * 8 -2))
      end

    end
  end
end


