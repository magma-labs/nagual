require 'csv'
require_relative 'reader'
require_relative 'configuration'

class CSVReader < Reader

  def initialize(path)
    csv_text     = File.read(path)
    first, *rest = *CSV.parse(csv_text, :headers => true)
    @content     = rest
    @headers     = first.map { |header| header.gsub(' ', '-').downcase.to_sym }
  end

  def read
    @content.map do |line|
      row = {}
      line.each_with_index.map do |value, index|
        row[@headers[index]] = value.strip
      end
      row
    end
  end

end
