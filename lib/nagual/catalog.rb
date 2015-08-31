module Nagual
  class Catalog

    def initialize(input_path)
      content = CSV.new(input_path).to_hash(product_attribute_keys)
      @xml    = XML.new(content, 'catalog', 'product', catalog_attributes)
    end

    def to_xml
      @xml.build
    end

    private

    def catalog_attributes
      { xmls: 'http://www.demandware.com/xml/impex/catalog/2006-10-31' }
    end

    def product_attribute_keys
      [:'product-id']
    end

  end
end
