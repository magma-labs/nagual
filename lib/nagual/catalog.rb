module Nagual
  class Catalog

    def initialize
      content = Database.load('products')
      groups  = Database.load('image_groups')
      images  = Database.load('images')

      groups  = CSV.add_children(groups, :images, images, :image)
      content = CSV.add_children(content, :images, groups, :'image-group')

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
