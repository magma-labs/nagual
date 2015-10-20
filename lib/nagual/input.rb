require 'csv'
require_relative 'configuration'

module Nagual
  class Input
    def initialize(csv_text)
      attributes, *content = *::CSV.parse(csv_text, headers: true)

      @content = content.map do |values|
        hash = {}
        values.each_with_index do |value, index|
          hash[attributes[index]] = value
        end
        hash
      end
    end

    def products
      @content.map { |attributes| Product.new(attributes) }
    end
  end
end
