require 'nokogiri'
require 'nagual/xml/product'

module Nagual
  module XML
    class Catalog
      def initialize(catalog)
        @attributes = catalog.attributes
        @products   = catalog.products
      end

      def output
        @output ||= build_output
      end

      private

      def build_output
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
          xml << Nagual::XML::Product.new(product).output
        end
      end
    end
  end
end
