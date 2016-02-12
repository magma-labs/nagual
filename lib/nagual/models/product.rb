require 'nagual/configuration'
require 'nagual/contract/fields/validation'
require 'nagual/models/product_variation'

module Nagual
  module Models
    class Product
      extend  Nagual::Configuration
      include Nagual::Configuration

      ATTRIBUTES  = config['product']['attributes']
      PAGE_FIELDS = config['product']['page_fields']
      FIELDS      = config['product']['fields']
      REQUIRED    = config['product']['required']

      PROPERTIES = ATTRIBUTES.merge(FIELDS).merge(PAGE_FIELDS)

      PROPERTIES.keys.each do |attribute|
        attr_reader attribute.to_sym
      end

      attr_reader :variations, :images, :custom_attributes, :errors
      alias to_s inspect

      def initialize(attributes: {}, variations: [], images: [])
        @variations        = variations
        @images            = images
        @custom_attributes = {}
        @errors            = []

        attributes.each do |key, value|
          set_attribute(key.to_s, value)
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
        @valid ||= validate
      end

      private

      def validate
        validate_required
        validate_by_type
        @errors.empty?
      end

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
        field = Contract::Fields::Validation.new(value, type)
        @errors << "#{name} is invalid. #{field.error}" unless field.valid?
      end

      def set_attribute(key, value)
        if PROPERTIES.keys.include?(key)
          instance_variable_set("@#{key}", value)
        else
          set_custom_attribute(key, value)
        end
      end

      def set_custom_attribute(key, value)
        return unless key.match(config['product']['custom_regex'])

        name = key.gsub(config['product']['custom_regex'], '').to_sym
        @custom_attributes[name] = value
      end

      def fields_hash(fields)
        fields.map do |field, _value|
          [field.to_s.tr('_', '-'), send(field)]
        end.to_h
      end
    end
  end
end
