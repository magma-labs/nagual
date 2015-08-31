require 'nokogiri'

module Nagual
  class XMLWriter < Writer

    def initialize(root_label, node_label, attributes, content)
      @content         = content
      @root_label      = root_label
      @node_label      = node_label
      @root_attributes = attributes
    end

    def write
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(@root_label, @root_attributes) {
          add_nodes(@node_label, xml)
        }
      end.to_xml
    end

    private

    def add_nodes(label, xml)
      @content.each do |hash|
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
