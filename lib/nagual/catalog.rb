module Nagual
  class Catalog
    def initialize
      @products = Input.load('products', 'data')
    end

    def to_xml
      content = Collection.new(@products).to_a
      XML.new(content, 'catalog', 'product', catalog_attributes).build
    end

    private

    def catalog_attributes
      Configuration.properties['catalog']['attributes']
    end
  end
end
