require 'test/unit'
require 'xml_writer'

class XMLWriterTest < Test::Unit::TestCase
  def test_write
    file = XMLWriter.new.write
    assert_not_nil file, "writing XML File failed"
  end
end
