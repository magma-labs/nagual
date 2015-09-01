module Nagual
  class Catalog

    def initialize
      content = Database.load('products')
      images  = Database.load('images')
      content = CSV.add_children(content, :images, images, :image)

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
