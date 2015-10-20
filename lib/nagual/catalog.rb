require 'nokogiri'

module Nagual
  class Catalog
    def initialize(products)
      @document = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send('catalog', attributes)
      end.doc
      @document.at('catalog') << Header.new.output
      products.each do |product|
        @document.at('catalog') << product.output
      end
    end

    def output
      @document.to_xml
    end

    private

    def attributes
      {
        xmlns:        'http://www.demandware.com/xml/impex/catalog/2006-10-31',
        'catalog-id': 'nagual-catalog'
      }
    end
  end
end
