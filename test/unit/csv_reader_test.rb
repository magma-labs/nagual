require 'test/unit'
require 'csv_reader'

class CSVReaderTest < Test::Unit::TestCase
  def test_we_can_open_csv_file
    file = CSVReader.new.read
    assert_not_nil file, "Openning CSV File failed"
  end

  def test_content_is_correct
    file = CSVReader.new.read
    assert(file[0][0] == "Rigo Tovar", "Cannot read headers")
  end

end
