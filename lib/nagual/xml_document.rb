require 'nokogiri'

module Nagual
  class XMLDocument
    def self.create(label, attributes = nil)
      document = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(label, attributes)
      end.doc

      XMLDocument.new(document)
    end

    def initialize(document)
      @document = document
    end

    def add_child(label, content)
      add_nodes(label, content, @document.root)

      XMLDocument.new(@document)
    end

    def add_child_below(label, parent, content)
      @document.css(label).each do |element|
        add_nodes(parent, content, element)
      end

      XMLDocument.new(@document)
    end

    def custom_sort(label, ordered_keys)
      @document.css("//#{label}").each do |parent|
        sorted = parent.children.sort_by do |element|
          ordered_keys.index(element.node_name) || 0
        end
        sorted.each{ |n| parent << n  }
      end

      XMLDocument.new(@document)
    end

    def to_xml
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
