module Nagual
  class Catalog
    def initialize(products)
      @document = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send('catalog', catalog_attributes)
      end.doc
      products.each { |product| @document.at('catalog') << product.output }
    end

    def output
      @document.to_xml
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
