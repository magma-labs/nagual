require 'csv'
require 'nagual/configuration'
require 'nagual/product'
require 'nagual/product_variation'

module Nagual
  module CSV
    class Input
      def initialize(file: Configuration.properties['input_file'])
        @variation_regex    = 'variation-'
        column_names, *rows = *::CSV.parse(File.read(file), headers: true)
        @content            = rows.map { |row| Hash[column_names.zip(row)] }
      end

      def products
        @products || parse_content_to_products
      end

      private

      def parse_content_to_products
        @content.map do |attributes|
          products_for(attributes)
        end
      end

      def products_for(attributes)
        product_attributes = attributes.select do |key|
          !key.to_s.match(@variation_regex)
        end

        Nagual::Product.new(attributes: product_attributes,
                            variations: variations_for(attributes))
      end

      def variations_for(attributes)
        variation_attributes = attributes.select do |key|
          key.to_s.match(@variation_regex)
        end

        variation_attributes.map do |key, value|
          id     = key.gsub(@variation_regex, '')
          values = value.split(',')

          Nagual::ProductVariation.new(id: id, values: values)
        end
      end
    end
  end
end
