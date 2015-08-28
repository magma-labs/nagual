require 'csv'
require_relative 'reader'
require_relative 'configuration'

module Nagual
  class CSVReader < Reader

    def initialize(csv_text)
      first, *rest = *CSV.parse(csv_text, :headers => true)
      @content     = rest
      @headers     = first.map { |header| header.gsub(' ', '-').downcase.to_sym }
    end

    def read
      @content.map do |line|
        row = {}
        line.each_with_index.map do |value, index|
          value = value.nil? ? "" : value.strip
          row[@headers[index]] = value
        end
        row
      end
    end

  end
end
