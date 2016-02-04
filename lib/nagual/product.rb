require 'nagual/configuration'

module Nagual
  class Product
    ATTRIBUTES  = Nagual::Configuration.properties['product']['attributes'].keys
    PAGE_FIELDS = Nagual::Configuration.properties['product']['page'].keys
    FIELD_KEYS  = Nagual::Configuration.properties['product']['fields'].keys

    PROPERTIES = ATTRIBUTES + FIELD_KEYS + PAGE_FIELDS

    PROPERTIES.each do |attribute|
      attr_reader attribute.to_sym
    end

    attr_reader :variations, :images, :custom_attributes, :errors

    def initialize(attributes: {}, variations: [], images: [])
      @variations        = variations
      @images            = images
      @custom_attributes = {}
      @errors            = []

      attributes.each do |key, value|
        if PROPERTIES.include?(key.to_s)
          instance_variable_set("@#{key}", value)
        else
          @custom_attributes[key.to_sym] = value
        end
      end
    end

    def attributes
      fields_hash(ATTRIBUTES)
    end

    def fields
      fields_hash(FIELD_KEYS)
    end

    def page_fields
      fields_hash(PAGE_FIELDS)
    end

    def variants_size
      @variations.map { |variation| variation.values.count }.reduce(:*) || 1
    end

    private

    def fields_hash(fields_array)
      fields_array.map do |field|
        [field.to_s.tr('_', '-'), send(field)]
      end.to_h
    end
  end
end
