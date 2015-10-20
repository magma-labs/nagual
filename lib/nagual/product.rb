module Nagual
  class Product
    ATTRIBUTES = [
      :product_id, :mode, :ean, :upc, :min_order_quantity, :step_quantity,
      :display_name, :short_description, :long_description, :online_flag,
      :online_from, :online_to, :searchable_flag,
      :searchable_if_unavailable_flag, :images, :template, :tax_class_id,
      :brand, :manufacturer_name, :manufacturer_sku, :search_replacement,
      :search_rank, :sitemap_included_flag, :sitemap_changefrequency,
      :sitemap_priority
    ]

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
  end
end
