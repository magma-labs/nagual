require 'nokogiri'

module Nagual
  module XML
    class Product
      def initialize(product)
        @product = product
      end

      def output
        Nokogiri::XML::Builder.new do |xml|
          xml.send('product', attributes) do
            add_elements(xml, Nagual::Product::ELEMENTS)
            xml.send('page-attributes') do
              add_elements(xml, Nagual::Product::PAGE_ELEMENTS)
            end
            xml.images do
              xml.send('image-group', 'view-type': 'default') do
                xml.image(path: "default/#{@product.product_id}")
              end
            end
          end
        end.doc.root.to_xml
      end

      def add_elements(xml, elements)
        elements.each do |element|
          xml.send(attribute_name(element), @product.send(element))
        end
      end

      def attributes
        Nagual::Product::ATTRIBUTES.inject({}) do |result, attribute|
          value = @product.send(attribute)
          if value
            result.merge!(attribute_name(attribute) => value)
          else
            result
          end
        end
      end

      def attribute_name(attribute)
        attribute.to_s.tr('_', '-')
      end
    end
  end
end
