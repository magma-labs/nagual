module Nagual
  class Product
    ATTRIBUTES = [:product_id, :mode].freeze
    FIELDS = [
      :ean, :upc, :min_order_quantity, :step_quantity, :display_name,
      :short_description, :long_description, :online_flag, :online_from,
      :online_to, :searchable_flag, :searchable_if_unavailable_flag,
      :template, :tax_class_id, :brand, :manufacturer_name, :manufacturer_sku,
      :search_placement, :search_rank, :sitemap_included_flag,
      :sitemap_changefrequency, :sitemap_priority
    ].freeze
    PAGE_FIELDS = [
      :page_title, :page_description, :page_keywords, :page_url
    ].freeze
    PROPERTIES = ATTRIBUTES + FIELDS + PAGE_FIELDS

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

    def attributes
      { 'product-id': product_id }
    end

    def fields
      fields_hash(FIELDS)
    end

    def page_fields
      fields_hash(PAGE_FIELDS)
    end

    private

    def fields_hash(fields_array)
      fields_array.map do |field|
        [field.to_s.tr('_', '-'), send(field)]
      end.to_h
    end
  end
end
