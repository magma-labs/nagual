require 'nokogiri'

module Nagual
  class Header
    def output
      Nokogiri::XML::Builder.new do |xml|
        xml.send('header') do
          xml.send('image-settings') do
            xml.send('internal-location', 'base-path': '/images')
            xml.send('view-types') do
              xml.send('view-type', 'default')
            end

            xml.send('alt-pattern', '${productname}')
            xml.send('title-pattern', '${productname}')
          end
        end
      end.doc.root
    end
  end
end
