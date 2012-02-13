module JSON
  class DataGenerator
    class TypeGenerator

      attr_accessor :current_node
      attr_accessor :required
      attr_accessor :optional
      attr_accessor :name

      def initialize(current_node = {}, name = nil)

        self.current_node = current_node
        self.name = name

        current_node.each { |element, value|
          case element
            when 'required' then
              self.required = RequiredCharacteristic.new(value)
            when 'optional' then
              self.optional = OptionalCharacteristic.new(value)
          end
        }

      end

      def abstract generate
        raise NotImplementedError
      end

      def self.create_generator(definition, name = nil)

        if definition["type"]
          if definition["type"].is_a?(String)
            type_instance = case definition["type"]
                              when 'integer' then
                                IntegerTypeGenerator.new(definition, name)
                              when 'number' then
                                NumberTypeGenerator.new(definition, name)
                              when 'string' then
                                StringTypeGenerator.new(definition, name)
                              when 'object' then
                                ObjectTypeGenerator.new(definition, name)
                              when 'null' then
                                NullTypeGenerator.new(definition, name)
                              when 'boolean' then
                                BooleanTypeGenerator.new(definition, name)
                              when 'array' then
                                ArrayTypeGenerator.new(definition, name)
                              else
                                raise JSON::ParserError.new("unknown type #{definition["type"]}")
                            end
          else
            type_instance = UnionTypeGenerator.new(definition, name)
          end
        else
          raise NotImplementedError
        end
        type_instance
      end

      protected
      def required?

        default = !self.required ? RequiredCharacteristic::default : self.required.value
        default || [true, false].sample
      end

      def optional?

        default = !self.optional ? OptionalCharacteristic::default : self.required.value
        default && [true, false].sample
      end
    end

  end
end