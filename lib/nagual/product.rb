require 'nagual/configuration'
require 'nagual/field'

module Nagual
  class Product
    CONFIG      = Nagual::Configuration.properties['product']
    ATTRIBUTES  = CONFIG['attributes']
    PAGE_FIELDS = CONFIG['page_fields']
    FIELDS      = CONFIG['fields']
    REQUIRED    = CONFIG['required']

    PROPERTIES = ATTRIBUTES.merge(FIELDS).merge(PAGE_FIELDS)

    PROPERTIES.keys.each do |attribute|
      attr_reader attribute.to_sym
    end

    attr_reader :variations, :images, :custom_attributes, :errors

    def initialize(attributes: {}, variations: [], images: [])
      @variations        = variations
      @images            = images
      @custom_attributes = {}
      @errors            = []

      attributes.each do |key, value|
        set_attribute(key, value)
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

    def valid?
      @errors = []
      validate_required
      validate_by_type
      @errors.empty?
    end

    private

    def validate_required
      REQUIRED.each { |name| validate_field(name, 'required') }
    end

    def validate_by_type
      PROPERTIES.each do |name, type|
        value = send(name.to_sym)
        validate_field(name, type) if !value.nil? && !value.empty?
      end
    end

    def validate_field(name, type)
      value = send(name.to_sym)
      field = Field.new(value, type)
      @errors << "#{name} is invalid. #{field.error}" unless field.valid?
    end

    def set_attribute(key, value)
      if PROPERTIES.keys.include?(key.to_s)
        instance_variable_set("@#{key}", value)
      else
        @custom_attributes[key.to_sym] = value
      end
    end

    def fields_hash(fields)
      fields.map do |field, _value|
        [field.to_s.tr('_', '-'), send(field)]
      end.to_h
    end
  end
end
