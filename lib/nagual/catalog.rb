module Nagual
  class Catalog
    def initialize
      @products = Input.load('products', 'data')
    end

    def to_xml
      XML.new(@products, 'catalog', 'product', catalog_attributes).build
    end

    private

    def catalog_attributes
      Configuration.properties['catalog']['attributes']
    end
  end
end
