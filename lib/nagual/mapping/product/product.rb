require 'nagual/mapping/base'

module Nagual
  module Mapping
    class Product < Base
      def transform
        @row.inject({}) do |transformed_row, map|
          transformed_row.merge(transformed_value(map[0], map[1]))
        end
      end

      private

      def transformed_value(key, value)
        mapping       = columns[key.to_s]
        bool_mutation = boolean_mutations[key.to_s]

        if mapping
          { mapping.to_s => value }
        elsif bool_mutation
          mutate_to_boolean(bool_mutation, value)
        else
          {}
        end
      end

      def mutate_to_boolean(mutation, value)
        { mutation['destination'] => (value == mutation['expected']).to_s }
      end

      def columns
        config['mapping']['product']['columns']
      end

      def boolean_mutations
        config['mapping']['product']['mutations']['boolean']
      end
    end
  end
end
