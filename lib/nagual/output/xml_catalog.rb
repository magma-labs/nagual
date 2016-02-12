require 'nokogiri'
require 'nagual/output/xml_product'
require 'nagual/logging'

module Nagual
  module Output
    class XMLCatalog
      include Nagual::Logging

      def initialize(catalog)
        @attributes = catalog.attributes
        @products   = catalog.products
      end

      def read
        @output ||= build_output
      end

      private

      def build_output
        logger.info('XMLCatalog') { 'Building xml output for catalog' }
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
          logger.debug('XMLCatalog') do
            "Parsing product with id: #{product.product_id}"
          end
          xml << Nagual::Output::XMLProduct.new(product).read
        end
      end
    end
  end
end
