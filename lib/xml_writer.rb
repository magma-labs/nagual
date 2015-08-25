require 'nokogiri'

class XMLWriter < Writer
  def write
    Nokogiri::XML::Builder.new do |xml|
      xml.root {
        xml.objects {
          xml.object.writing.thing!
        }
      }
    end.to_xml
  end
end
