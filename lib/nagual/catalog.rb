module Nagual
  class Catalog

    def initialize
      content = Products.new.to_a
      content = add_child_element(content, :images, Images.new.to_a)

      @xml = XML.new(content, 'catalog', 'product', catalog_attributes)
    end

    def to_xml
      @xml.build
    end

    private

    def catalog_attributes
      Configuration.properties['catalog']['attributes']
    end

    def add_child_element(content, key, value)
      content.map do |item|
        item[:elements].each do |element|
          element[key] = value
        end
        item
      end
    end

  end
end
