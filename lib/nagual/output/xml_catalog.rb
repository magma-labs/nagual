require 'nokogiri'
require 'nagual/logging'
require 'nagual/output/xml_product'

module Nagual
  module Output
    class XmlCatalog
      include Nagual::Logging

      def write!(objects, _errors)
        @products = objects
        build_output
      end

      private

      def build_output
        logger.info('XmlCatalog') { 'Building xml output for catalog' }
        Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send('catalog', attributes) do
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
          logger.debug('XmlCatalog') do
            "Parsing product with id: #{product.product_id}"
          end
          xml << Nagual::Output::XMLProduct.new(product).read
        end
      end

      def attributes
        {
          xmlns:        'http://www.demandware.com/xml/impex/catalog/2006-10-31',
          'catalog-id': 'nagual-catalog'
        }
      end
    end
  end
end
