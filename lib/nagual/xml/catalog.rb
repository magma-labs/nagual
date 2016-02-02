require 'nokogiri'
require 'nagual/xml/product'

module Nagual
  module XML
    class Catalog
      def initialize(catalog)
        @document = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send('catalog', catalog.attributes) do
            header(xml)

            catalog.products.each do |product|
              Nagual::XML::Product.new(product).output
            end
          end
        end
      end

      def output
        @document.to_xml
      end

      def header(xml)
        xml.send('header') do
          xml.send('image-settings') do
            xml.send('internal-location', 'base-path': '/images')
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
    end
  end
end
