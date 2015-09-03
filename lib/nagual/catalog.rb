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
      values  = CSV.add_children(@values, :'option-value-prices',
                                 @prices, :'option-value-price')
      groups  = CSV.add_children(@groups, :images, @images, :image)
      options = CSV.add_children(@options, :'option-values',
                                 values, :'option-value')

      content = @products
      content = CSV.add_children(content, :images, groups, :'image-group')
      content = CSV.add_children(content, :'page-attributes', @attributes)
      content = CSV.add_children(content, :'bundled-products',
                                 @bundled, :'bundled-product')
      content = CSV.add_children(content, :'product-set-products',
                                 @sets, :'product-set-product')
      content = CSV.add_children(content, :'options', options, :option)
      content = CSV.add_children(content, :'product-links',
                                 @links, :'product-link')

      XML.new(content, 'catalog', 'product', catalog_attributes).build
    end

    private

    def catalog_attributes
      Configuration.properties['catalog']['attributes']
    end

  end
end
