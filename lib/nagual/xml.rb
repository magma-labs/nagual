require 'nokogiri'

module Nagual
  class XML
    def self.document(content, root_label, node_label, root_attributes)
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(root_label, root_attributes) do
          add_nodes(node_label, content, xml)
        end
      end.doc
    end

    def self.add_nodes(label, array, xml)
      array.each do |hash|
        hash[:elements].each do |element|
          xml.send(label, hash[:attributes]) do
            element.each do |key, value|
              if value.is_a?(Array)
                add_nodes(key, value, xml)
              else
                xml.send(key, value)
              end
            end
          end
        end
      end
    end
  end
end
