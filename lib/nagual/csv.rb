require 'csv'
require_relative 'configuration'

module Nagual
  class CSV
    def initialize(csv_text)
      first, *rest = *::CSV.parse(csv_text, headers: true)
      @content     = rest
      @headers     = first.map { |header| header.tr(' ', '-').downcase.to_sym }
    end

    def to_a(attribute_keys = [])
      @content.map { |line| split_by_type(line, attribute_keys) }
    end

    def self.add_children(parent, parent_key, children, child_key = nil)
      parent.map do |item|
        item[:elements].map do |element|
          element[parent_key] =
            represent_elements(child_key, children[:elements],
                               children[:attributes])
          element
        end
        item
      end
    end

    private

    def split_by_type(line, attribute_keys)
      attributes = {}
      elements   = {}

      line.each_with_index do |value, index|
        key   = @headers[index]
        value = value.nil? ? '' : value.strip

        if attribute_keys.include?(key)
          attributes[key] = value
        else
          elements[key] = value
        end
      end

      { attributes: attributes, elements: [elements] }
    end

    def self.represent_elements(key, elements, attributes)
      if key.nil?
        [{ elements: elements, attributes: attributes }]
      else
        [{ elements: [{ "#{key}": [
          { elements: elements, attributes: attributes }
        ] }] }]
      end
    end
  end
end
