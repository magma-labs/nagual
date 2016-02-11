require 'nokogiri'
require 'nagual/xml/product'
require 'nagual/logging'

module Nagual
  module XML
    class Catalog
      include Nagual::Logging

      def initialize(catalog)
        @attributes = catalog.attributes
        @products   = catalog.products
      end

      def output
        @output ||= build_output
      end

      private

      def build_output
        logger.info('Building xml output for catalog')
        Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send('catalog', @attributes) do
            add_header(xml)
            add_products(xml)
          end
        end.to_xml
      end

      def add_header(xml)
        xml.send('header') do
          xml.send('image-settings') do
            xml.send('internal-location', 'base-path': '/')
            xml.send('view-types') do
              xml.send('view-type', 'large')
              xml.send('view-type', 'medium')
              xml.send('view-type', 'small')
              xml.send('view-type', 'swatch')
            end

            xml.send('alt-pattern', '${productname}')
            xml.send('title-pattern', '${productname}')
          end
        end
      end

      def add_products(xml)
        @products.each do |product|
          logger.debug("Parsing product with id: #{product.product_id}")
          xml << Nagual::XML::Product.new(product).output
        end
      end
    end
  end
end
