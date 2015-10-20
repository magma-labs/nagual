module Nagual
  class Catalog
    def initialize(input_file)
      # TODO: Add products to document
      _products = Input.new(input_file).products
      @document = Document.create('catalog', catalog_attributes)
                  .add_child('header', header)
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
  end
end
