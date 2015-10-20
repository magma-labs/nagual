module Nagual
  class Catalog
    def initialize(input_file)
      products  = Input.new(input_file).to_a(product_attribute_keys)
      @document = Document.create('catalog', catalog_attributes)
                  .add_child('header', header)
                  .add_child('product', products)
                  .add_child_below('product', 'images', images)
                  .custom_sort('product', product_element_keys)
    end

    def output
      @document.output
    end

    private

    def catalog_attributes
      Configuration.properties['catalog']['attributes']
    end

    def header
      [Configuration.properties['header']]
    end

    def images
      [Configuration.properties['images']]
    end

    def product_attribute_keys
      Configuration.properties['product']['attribute_keys']
    end

    def product_element_keys
      Configuration.properties['product']['element_keys']
    end
  end
end
