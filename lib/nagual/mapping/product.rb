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
        mapping = columns[key.to_s]
        mapping ? { "#{mapping}": value } : {}
      end

      def columns
        config['mapping']['product']['columns']
      end
    end
  end
end
