require 'nokogiri'
require 'nagual/util/logging'
require 'nagual/util/configuration'
require 'nagual/output/xml_product'

module Nagual
  module Output
    class XmlCatalog
      include Nagual::Logging
      include Nagual::Configuration

      def write(products, _errors)
        @products = products
        build_output
      end

      def write!(objects, errors)
        File.open(catalog_config['file'], 'w') do |file|
          file.write(write(objects, errors))
        end
      end

      private

      def catalog_config
        config['output']['xml']['catalog']
      end

      def build_output
        info("Building xml output for catalog with #{@products.count} products")
        Nokogiri::XML::Builder
          .new(encoding: catalog_config['encoding']) do |xml|
          xml.send('catalog', attributes) do
            add_header(xml)
            add_products(xml)
          end
        end.to_xml
      end

      def add_header(xml)
        xml.send('header') do
          add_image_settings(xml)
        end
      end

      def add_image_settings(xml)
        xml.send('image-settings') do
          xml.send('internal-location',
                   'base-path': catalog_config['images']['path'])
          add_view_types(xml)
          add_variation_attributes(xml)
          xml.send('alt-pattern', catalog_config['images']['alt'])
          xml.send('title-pattern', catalog_config['images']['title'])
        end
      end

      def add_variation_attributes(xml)
        catalog_config['variation_attributes'].each do |attribute|
          xml.send('variation-attribute-id', attribute)
        end
      end

      def add_products(xml)
        @products.each do |product|
          product_xml = Nagual::Output::XMLProduct.new(product).read
          debug("XML for product with id #{product.product_id}: #{product_xml}")
          xml << product_xml
        end
      end

      def add_view_types(xml)
        xml.send('view-types') do
          catalog_config['view_types'].each do |name|
            xml.send('view-type', name)
          end
        end
      end

      def attributes
        { xmlns: catalog_config['xmlns'], 'catalog-id': catalog_config['id'] }
      end
    end
  end
end
