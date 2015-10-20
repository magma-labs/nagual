require 'nokogiri'

module Nagual
  class Document
    def self.create(label, attributes = nil)
      document = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(label, attributes)
      end.doc

      Document.new(document)
    end

    def initialize(document)
      @document = document
    end

    def add_child(label, content)
      add_nodes(label, content, @document.root)

      Document.new(@document)
    end

    def output
      @document.to_xml
    end

    private

    def add_nodes(label, content, parent)
      content.each do |hash|
        child = Nokogiri::XML::Node.new label, @document

        hash[:attributes].each { |key, value| child[key] = value }
        hash[:elements].each   { |element| add_node(child, element) }

        parent << child
      end
    end

    def add_node(child, element)
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
  end
end
