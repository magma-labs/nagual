require 'nokogiri'

class XMLWriter < Writer
  def write
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root {
      xml.objects {
        xml.object.writing.thing!
      }
    }
    end
    return builder.to_xml
  end
end
