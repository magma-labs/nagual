require 'nokogiri'

module Nagual
  module XML
    class Product
      def initialize(product)
        @product = product
      end

      def output
        Nokogiri::XML::Builder.new do |xml|
          xml.send('product', @product.attributes) do
            add_fields(xml, @product.fields)
            xml.send('page-attributes') do
              add_fields(xml, @product.page_fields)
            end

            xml.images do
              xml.send('image-group', 'view-type': 'default') do
                xml.image(path: "default/#{@product.product_id}")
              end
            end
          end
        end.doc.root.to_xml
      end

      private

      def add_fields(xml, fields)
        fields.each do |name, value|
          xml.send(name, value)
        end
      end
    end
  end
end
