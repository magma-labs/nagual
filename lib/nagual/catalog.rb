module Nagual
  class Catalog

    def initialize
      @groups      = Database.load('image_groups')
      @options     = Database.load('options')
      @values      = Database.load('option_values')
      @images      = Database.load('images')
      @prices      = Database.load('option_value_prices')
      @products    = Database.load('products')
      @attributes  = Database.load('page_attributes')
      @bundled     = Database.load('bundled_products')
      @sets        = Database.load('product_set_products')
      @links       = Database.load('product_links')
    end

    def to_xml
      content = Collection.new(@products).
        add_image_groups(@groups, @images).
        add_page_attributes(@attributes).
        add_bundled_products(@bundled).
        add_set_products(@sets).
        add_options(@options, @values, @prices).
        add_product_links(@links)
        to_a

      XML.new(content, 'catalog', 'product', catalog_attributes).build
    end

    private

    def catalog_attributes
      Configuration.properties['catalog']['attributes']
    end

  end
end
