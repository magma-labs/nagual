require 'nokogiri'

module Nagual
  class Product
    ATTRIBUTES     = [:product_id, :mode]
    FIRST_ELEMENTS = [
      :ean, :upc, :min_order_quantity, :step_quantity, :display_name,
      :short_description, :long_description, :online_flag, :online_from,
      :online_to, :searchable_flag, :searchable_if_unavailable_flag
    ]
    LAST_ELEMENTS = [
      :template, :tax_class_id,
      :brand, :manufacturer_name, :manufacturer_sku, :search_placement,
      :search_rank, :sitemap_included_flag, :sitemap_changefrequency,
      :sitemap_priority
    ]

    PROPERTIES = ATTRIBUTES + FIRST_ELEMENTS + LAST_ELEMENTS
    PROPERTIES.each do |attribute|
      attr_reader attribute
    end

    def initialize(attributes)
      valid_attributes = attributes.select do |key, _value|
        PROPERTIES.include?(key.to_sym)
      end
      valid_attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def output
      Nokogiri::XML::Builder.new do |xml|
        xml.send('product', attributes) do
          add_elements(xml, FIRST_ELEMENTS)
          xml.images do
            xml.send('image-group', 'view-type': 'default') do
              xml.image(path: "default/#{product_id}")
            end
          end
          add_elements(xml, LAST_ELEMENTS)
        end
      end.doc.root
    end

    private

    def attributes
      ATTRIBUTES.inject({}) do |result, attribute|
        value = send(attribute)
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

    def add_elements(xml, elements)
      elements.each do |element|
        xml.send(attribute_name(element), send(element))
      end
    end
  end
end
