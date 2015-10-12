module Nagual
  class Catalog
    def initialize(input_file)
      @products = CSV.new(input_file).to_a(product_attribute_keys)
      @document = XML.new(@products, 'catalog', 'product', catalog_attributes)
    end

    def to_xml
      @document.build
    end

    private

    def catalog_attributes
      Configuration.properties['catalog']['attributes']
    end

    def product_attribute_keys
      Configuration.properties['product']['attribute_keys']
    end
  end
end
