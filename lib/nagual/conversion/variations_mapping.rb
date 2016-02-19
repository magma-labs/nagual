require 'nagual/configuration'

module Nagual
  module Conversion
    class VariationsMapping
      include Nagual::Configuration

      def initialize(row)
        @row = row
      end

      def transform
        variation_names.map { |name| variation_value(@row, name) }.compact
      end

      private

      def variation_value(row, variation_name)
        variation = row[variation_name] || ''
        values    = variation.split(',')
        { id: variation_name.to_s, values: values } unless values.empty?
      end

      def variation_names
        config['mapping']['product']['variations']
      end
    end
  end
end
