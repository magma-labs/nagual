require 'csv'
require_relative 'configuration'

module Nagual
  class CSV

    def initialize(csv_text)
      first, *rest = *::CSV.parse(csv_text, :headers => true)
      @content     = rest
      @headers     = first.map { |header| header.gsub(' ', '-').downcase.to_sym }
    end

    def to_hash(attribute_keys=[])
      @content.map do |line|
        split_by_type(line, attribute_keys, attributes={}, elements={})

        { attributes: attributes, elements: [elements] }
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

  end
end
