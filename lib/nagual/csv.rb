require 'csv'
require_relative 'configuration'

module Nagual
  class CSV

    def initialize(csv_text)
      first, *rest = *::CSV.parse(csv_text, :headers => true)
      @content     = rest
      @headers     = first.map { |header| header.gsub(' ', '-').downcase.to_sym }
    end

    def to_a(attribute_keys=[])
      @content.map do |line|
        split_by_type(line, attribute_keys, attributes={}, elements={})

        { attributes: attributes, elements: [elements] }
      end
    end

    def self.add_children(parent, parent_key, children, child_key)
      parent.map do |item|
        item[:elements].map do |element|
          ids                 = element[parent_key].split(',')
          elements            = children_elements(children, ids)
          element[parent_key] = represent_elements(child_key, elements)
          element
        end
        item
      end
    end

    private

    def split_by_type(line, attribute_keys, attributes, elements)
      line.each_with_index do |value, index|
        key   = @headers[index]
        value = value.nil? ? "" : value.strip

        if attribute_keys.include?(key)
          attributes[key] = value
        else
          elements[key] = value
        end
      end
    end

    def self.children_elements(children, ids)
      children.select do |child|
        ids.include?(child[:elements].first[:id])
      end.map do |child|
        elements = child[:elements].first
        elements.delete(:id)
        elements
      end
    end

    def self.represent_elements(key, elements)
      [{ elements: [{ "#{key}": [{ elements: elements }] }] }]
    end

  end
end
