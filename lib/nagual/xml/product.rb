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
            add_attributes(xml, @product)
            add_images(xml, @product.product_id)
            add_variations(xml, @product.variations)
            add_variants(xml, @product.product_id, @product.variants_size)
          end
        end.doc.root.to_xml
      end

      private

      def add_attributes(xml, _product)
        @product.fields.each do |name, value|
          xml.send(name, value) unless value.nil?
        end

        xml.send('page-attributes') do
          @product.page_fields.each do |name, value|
            xml.send(name, value) unless value.nil?
          end
        end
      end

      def add_images(xml, product_id)
        xml.images do
          xml.send('image-group', 'view-type': 'default') do
            xml.image(path: "default/#{product_id}")
          end
        end
      end

      def add_variations(xml, variations)
        variations.each do |variation|
          xml.send('variations') do
            xml.send('attributes') do
              xml.send('variation-attribute',
                       'attribute-id': variation.id,
                       'variation-attribute-id': variation.id) do
                         add_variation_attributes(xml, variation.values)
                       end
            end
          end
        end
      end

      def add_variation_attributes(xml, values)
        xml.send('variation-attribute-values') do
          values.each do |value|
            xml.send('variation-attribute-value', value: value[:value]) do
              xml.send('display-value', { 'xml:lang': 'x-default' },
                       value[:display])
            end
          end
        end
      end

      def add_variants(xml, product_id, size)
        xml.send('variants') do
          size.times do |index|
            xml.send('variant', 'product-id': "#{product_id}_#{index + 1}")
          end
        end
      end
    end
  end
end
