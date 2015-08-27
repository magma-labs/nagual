require 'nokogiri'

module Nagual
  class XMLWriter < Writer

    def initialize(content)
      @content = content
    end

    def write
      Nokogiri::XML::Builder.new do |xml|
        xml.catalog {
          process_array('product', @content, xml)
        }
      end.to_xml
    end

    private

    def process_array(label, array, xml)
      array.each do |hash|
        xml.send(label) do
          hash.each do |key, value|
            process_value(value, key, xml)
          end
        end
      end
    end

    def process_value(value, key, xml)
      if value.is_a?(Array)
        process_array(key, value, xml)
      else
        xml.send(key, value)
      end
    end

  end
end
