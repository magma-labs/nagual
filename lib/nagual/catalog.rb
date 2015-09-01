module Nagual
  class Catalog

    def initialize
      content = Products.new.to_hash

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
end
