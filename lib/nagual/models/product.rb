require 'nagual/models/product_variation'

module Nagual
  module Models
    class Product
      ATTRIBUTES  = [:product_id].freeze
      FIELDS      = [:ean, :upc, :unit, :min_order_quantity,
                     :step_quantity, :display_name, :short_description,
                     :long_description, :online_flag, :online_from, :online_to,
                     :available_flag, :searchable_flag,
                     :searchable_if_unavailable_flag, :template, :tax_class_id,
                     :brand, :manufacturer_name, :manufacturer_sku,
                     :search_placement, :search_rank, :sitemap_included_flag,
                     :sitemap_changefrequency, :sitemap_priority].freeze
      PAGE_FIELDS = [:page_title, :page_description, :page_keywords,
                     :page_url].freeze
      PROPERTIES  = ATTRIBUTES + FIELDS + PAGE_FIELDS

      PROPERTIES.each do |attribute|
        attr_reader attribute.to_sym
      end

      attr_reader :variations, :images, :custom_attributes

      alias to_s inspect

      def initialize(attributes: {}, variations: [], images: [])
        @variations        = variations.map { |v| ProductVariation.new(v) }
        @images            = images
        @custom_attributes = {}

        attributes.each do |key, value|
          set_attribute(key.to_sym, value)
        end
      end

      def attributes
        fields_hash(ATTRIBUTES)
      end

      def fields
        fields_hash(FIELDS)
      end

      def page_fields
        fields_hash(PAGE_FIELDS)
      end

      def variants_size
        @variations.map { |variation| variation.values.count }.reduce(:*) || 1
      end

      private

      def set_attribute(key, value)
        if PROPERTIES.include?(key)
          instance_variable_set("@#{key}", value)
        else
          @custom_attributes[key] = value
        end
      end

      def fields_hash(fields)
        fields.map do |field, _value|
          [field.to_s.tr('_', '-'), send(field)]
        end.to_h
      end
    end
  end
end
