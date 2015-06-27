require 'test/unit'
require 'xml_writer'

class XMLWriterTest < Test::Unit::TestCase
  def test_write_xml_file
    file = XMLWriter.new.write_xml_file
    assert_not_nil file, "writing XML File failed"
  end
end
