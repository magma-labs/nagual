require 'csv'
require 'nagual/models/product'
require 'nagual/configuration'
require 'nagual/logging'

module Nagual
  module Input
    class CSV
      include Nagual::Logging
      include Nagual::Configuration

      def initialize(file)
        logger.info('Input::CSV') { "Opening #{file} to read csv content" }
        column_names, *rows = *::CSV.parse(File.read(file), headers: true)
        logger.debug('Input::CSV') { "Column names extracted: #{column_names}" }
        @content = rows.map { |row| Hash[column_names.zip(row)] }
      end

      def valid_products
        products.select(&:valid?)
      end

      def invalid_products
        products.select { |product| !product.valid? }
      end

      private

      def products
        @products || parse_content_to_products
      end

      def parse_content_to_products
        logger.debug('Input::CSV') { 'Parsing content to products' }
        @content.map do |attrs|
          product = Nagual::Models::Product
                    .new(attributes: product_attributes(attrs),
                         variations: variations_for(attrs),
                         images: images_for(attrs))
          logger.debug('Input::CSV') { "Product created: #{product}" }
          product
        end
      end

      def product_attributes(attributes)
        attributes.select do |key|
          key != 'images' && !key.match(config['product']['variation_regex'])
        end
      end

      def variations_for(attributes)
        variation_attributes = attributes.select do |key|
          key.to_s.match(config['product']['variation_regex'])
        end

        variation_attributes.map do |key, value|
          id     = key.gsub(config['product']['variation_regex'], '')
          values = value.split(',')

          Nagual::Models::ProductVariation.new(id: id, values: values)
        end
      end

      def images_for(attributes)
        images = attributes['images'] || ''
        images.split(',')
      end
    end
  end
end