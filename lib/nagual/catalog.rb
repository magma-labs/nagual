module Nagual
  class Catalog

    def initialize
      content    = Database.load('products')
      groups     = Database.load('image_groups')
      images     = Database.load('images')
      attributes = Database.load('page_attributes')
      products   = Database.load('bundled_products')

      groups  = CSV.add_children(groups, :images, images, :image)
      content = CSV.add_children(content, :images, groups, :'image-group')
      content = CSV.add_children(content, :'page-attributes', attributes)
      content = CSV.add_children(content, :'bundled-products', products, :'bundled-product')

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
