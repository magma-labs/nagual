module Nagual
  class Catalog

    def initialize
      content    = Database.load('products')
      groups     = Database.load('image_groups')
      images     = Database.load('images')
      attributes = Database.load('page_attributes')
      products   = Database.load('bundled_products')
      sets       = Database.load('product_set_products')
      options    = Database.load('options')
      values     = Database.load('option_values')
      prices     = Database.load('option_value_prices')

      groups  = CSV.add_children(groups, :images, images, :image)
      values  = CSV.add_children(values, :'option-value-prices', prices,
                                 :'option-value-price')
      options = CSV.add_children(options, :'option-values', values,
                                 :'option-value')

      content = CSV.add_children(content, :images, groups, :'image-group')
      content = CSV.add_children(content, :'page-attributes', attributes)
      content = CSV.add_children(content, :'bundled-products', products,
                                 :'bundled-product')
      content = CSV.add_children(content, :'product-set-products', sets,
                                 :'product-set-product')
      content = CSV.add_children(content, :'options', options, :option)
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
