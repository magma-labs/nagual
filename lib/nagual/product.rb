module Nagual
  class Product
    FIRST_ATTRIBUTES = [
      :product_id, :mode, :ean, :upc, :min_order_quantity, :step_quantity,
      :display_name, :short_description, :long_description, :online_flag,
      :online_from, :online_to, :searchable_flag,
      :searchable_if_unavailable_flag
    ]
    LAST_ATTRIBUTES = [:images, :template, :tax_class_id,
      :brand, :manufacturer_name, :manufacturer_sku, :search_replacement,
      :search_rank, :sitemap_included_flag, :sitemap_changefrequency,
      :sitemap_priority
    ]

    ATTRIBUTES = FIRST_ATTRIBUTES + LAST_ATTRIBUTES
    ATTRIBUTES.each do |attribute|
      attr_reader attribute
    end

    def initialize(attributes)
      valid_attributes = attributes.select do |key, _value|
        ATTRIBUTES.include?(key.to_sym)
      end
      valid_attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def output
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send('product', attributes) do
          FIRST_ATTRIBUTES.each { |property| xml.send(property, send(property)) }
          xml.images {
            xml.send('image-group', view_type: 'default') {
              xml.image(path: "default/#{product_id}")
            }
          }
          LAST_ATTRIBUTES.each { |property| xml.send(property, send(property)) }
        end
      end.doc
    end

    private

    def images
      {image_group: 'hi'}
    end

    def attributes
      { product_id: product_id, mode: mode }
    end
  end
end
