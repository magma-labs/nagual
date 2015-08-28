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
            xml.send(key, value)
          end
        end
      end
    end

  end
end
