require 'nagual/mapping/base'

module Nagual
  module Mapping
    class ProductVariations < Base
      def transform
        variation_names.map { |name| variation_value(@row, name) }.compact
      end

      private

      def variation_value(row, variation_name)
        variation = row[variation_name.to_sym] || ''
        values    = variation.split(',')
        { id: variation_name.to_s, values: values } unless values.empty?
      end

      def variation_names
        config['mapping']['product']['variations']
      end
    end
  end
end
