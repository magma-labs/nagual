require 'csv'
require 'nagual/configuration'
require 'nagual/product'

module Nagual
  module CSV
    class Input
      def initialize(file: Configuration.properties['input_file'])
        attributes, *content = *::CSV.parse(File.read(file), headers: true)

        @content = content.map do |values|
          hash = {}
          values.each_with_index do |value, index|
            hash[attributes[index]] = value
          end
          hash
        end
      end

      def products
        @content.map { |attrs| Nagual::Product.new(attributes: attrs) }
      end
    end
  end
end
