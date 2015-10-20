require 'csv'
require_relative 'configuration'

module Nagual
  class Input
    def initialize(csv_text)
      header, *rest = *::CSV.parse(csv_text, headers: true)

      @content = rest.map.each_with_index do |value, index|
        hash = {}
        hash[header[index]] = value[index]
        hash
      end
    end

    def products
      @content.map { |attributes| Product.new(attributes) }
    end
  end
end
