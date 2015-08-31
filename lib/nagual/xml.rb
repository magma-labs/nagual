require 'nokogiri'

module Nagual
  class XML

    def initialize(content, root_label, node_label, attributes)
      @content         = content
      @root_label      = root_label
      @node_label      = node_label
      @root_attributes = attributes
    end

    def build(attribute_keys=[])
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(@root_label, @root_attributes) {
          add_nodes(@node_label, xml, attribute_keys)
        }
      end.to_xml
    end

    private

    def add_nodes(label, xml, attribute_keys)
      @content.each do |hash|
        attributes = attribute_keys.map {|attr| [attr, hash[attr]] }.to_h
        xml.send(label, attributes) do
          hash.each do |key, value|
            xml.send(key, value) unless attribute_keys.include?(key)
          end
        end
      end
    end

  end
end
