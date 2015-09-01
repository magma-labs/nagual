module Nagual
  class Catalog

    def initialize
      content = Products.new.to_a
      content = CSV.add_children(content, :images, Images.new.to_a, :image)

      @xml = XML.new(content, 'catalog', 'product', catalog_attributes)
    end

    def to_xml
      @xml.build
    end

    private

    def catalog_attributes
      Configuration.properties['catalog']['attributes']
    end

  end
end
