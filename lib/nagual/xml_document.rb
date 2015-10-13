require 'nokogiri'

module Nagual
  class XMLDocument

    def initialize(label, attributes=nil)
      @document = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(label, attributes)
      end.doc
    end

    def add_child(label, content)
      add_nodes(label, content, @document.root)

      @document
    end

    def to_xml
      @document.to_xml
    end

    private

    def add_nodes(label, content, parent)
      content.each do |hash|
        child = Nokogiri::XML::Node.new label, @document

        hash[:attributes].each do |key, value|
          child[key] = value
        end
        hash[:elements].each do |element|
          element.each do |key, value|
            if value.is_a?(Array)
              add_nodes(key.to_s, value, child)
            else
              node = Nokogiri::XML::Node.new key.to_s, @document
              node.content = value
              child << node
            end
          end
        end

        parent << child
      end
    end
  end
end
