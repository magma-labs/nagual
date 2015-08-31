require 'nokogiri'

module Nagual
  class XMLWriter < Writer

    def initialize(content)
      @elements = content
    end

    def write
      Nokogiri::XML::Builder.new do |xml|
        xml.catalog {
          add_node('product', xml)
        }
      end.to_xml
    end

    private

    def add_node(label, xml)
      @elements.each do |hash|
        xml.send(label, hash[:attributes]) do
          hash.each do |key, value|
            if key != :attributes
              xml.send(key, value)
            end
          end
        end
      end
    end

  end
end
