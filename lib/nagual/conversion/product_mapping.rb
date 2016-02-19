require 'nagual/util/configuration'

module Nagual
  module Conversion
    class ProductMapping
      include Nagual::Configuration

      def initialize(row)
        @row = row
      end

      def transform
        @row.inject({}) do |transformed_row, map|
          transformed_row.merge(transformed_value(map[0], map[1]))
        end
      end

      private

      def transformed_value(key, value)
        mutation = product_mutations.find { |m| key == m['key'] }
        return {} unless mutation

        { mutation['to'] =>
          mutate(mutation['name'], value, mutation['params']) }
      end

      def mutate(name, value, params)
        case name
        when 'none' then value
        when 'boolean' then (value == params['expected']).to_s
        end
      end

      def product_mutations
        config['mapping']['product']['mutations']
      end
    end
  end
end
