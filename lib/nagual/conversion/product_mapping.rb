module Nagual
  module Conversion
    class ProductMapping
      def initialize(row, mutations)
        @row       = row
        @mutations = mutations
      end

      def transform
        @row.inject({}) do |transformed_row, map|
          transformed_row.merge(transformed_value(map[0], map[1]))
        end
      end

      private

      def transformed_value(key, value)
        mutation = @mutations.find { |m| key == m['key'] }
        return {} unless mutation
        return {} unless value

        { mutation['to'] =>
          mutate(mutation['name'], value, mutation['params']) }
      end

      def mutate(name, value, params)
        case name
        when 'none' then value
        when 'convert'
          convert(name, value, params)
        end
      end

      def convert(_name, value, params)
        return params['values'][value] if params['values'][value]

        params['default'] == 'NONE' ? value : params['default']
      end
    end
  end
end
