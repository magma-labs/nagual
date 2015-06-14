require 'test/unit'
require 'csv_reader'

class CSVReaderTest < Test::Unit::TestCase
  def test_we_can_open_csv_file
    file = CSVReader.new.read_csv_file
    assert_not_nil file, "Openning CSV File failed"
  end
end
