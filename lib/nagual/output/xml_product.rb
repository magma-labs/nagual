require 'nokogiri'
require 'nagual/util/configuration'

module Nagual
  module Output
    class XMLProduct
      include Nagual::Configuration

      def initialize(product)
        @attributes        = product.attributes
        @fields            = product.fields
        @page_fields       = product.page_fields
        @custom_attributes = product.custom_attributes
        @images            = product.images
        @id                = product.product_id
        @variations        = product.variations
        @variants_size     = product.variants_size
      end

      def read
        @output ||= build_output
      end

      private

      def build_output
        Nokogiri::XML::Builder.new do |xml|
          xml.send('product', @attributes) do
            add_attributes(xml)
            add_custom_attributes(xml)
            add_variations(xml)
          end
        end.doc.root.to_xml
      end

      def add_attributes(xml)
        @fields.each do |name, value|
          add_images(xml) if name == 'template'
          xml.send(name, value) unless value.nil?
        end

        xml.send('page-attributes') do
          @page_fields.each do |name, value|
            xml.send(name, value) unless value.nil?
          end
        end
      end

      def add_custom_attributes(xml)
        xml.send('custom-attributes') do
          @custom_attributes.each do |key, value|
            xml.send('custom-attribute', { 'attribute-id': key }, value)
          end
        end
      end

      def add_images(xml)
        xml.images do
          catalog_config['view_types'].each do |view_type|
            names = @images[view_type]
            next unless names
            xml.send('image-group', 'view-type': view_type) do
              names.each do |name|
                path = product_config['image'] %
                       { id: @id, type: view_type, name: name }
                xml.image(path: path)
              end
            end
          end
        end
      end

      def add_variations(xml)
        return if @variations.empty?
        xml.send('variations') do
          xml.send('attributes') do
            @variations.each do |variation|
              xml.send('variation-attribute',
                       'attribute-id': variation.id,
                       'variation-attribute-id': variation.id) do
                         add_variation_attributes(xml, variation.values)
                       end
            end
          end
          add_variants(xml)
        end
      end

      def add_variation_attributes(xml, values)
        xml.send('variation-attribute-values') do
          values.each do |value|
            xml.send('variation-attribute-value', value: value.value) do
              xml.send('display-value', { 'xml:lang': product_config['lang'] },
                       value.display)
            end
          end
        end
      end

      def add_variants(xml)
        xml.send('variants') do
          @variants_size.times do |index|
            id = product_config['variant'] % { name: @id, modifier: index + 1 }
            xml.send('variant', 'product-id': id)
          end
        end
      end

      def product_config
        config['output']['xml']['product']
      end

      def catalog_config
        config['output']['xml']['catalog']
      end
    end
  end
end
