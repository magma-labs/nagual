module Nagual
  class Catalog
    def initialize(input_file)
      @products = CSV.new(input_file).to_a(product_attribute_keys)
      @document = XMLDocument.new('catalog', catalog_attributes)

      @document.add_child('header', header)
      @document.add_child('product', @products)
    end

    def to_xml
      @document.to_xml
    end

    private

    def catalog_attributes
      Configuration.properties['catalog']['attributes']
    end

    def product_attribute_keys
      Configuration.properties['product']['attribute_keys']
    end

    def header
      [Configuration.properties['header']]
    end
  end
end
