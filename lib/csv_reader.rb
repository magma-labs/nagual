require 'csv'
require 'reader'

class CSVReader < Reader

  def read
    csv_text = File.read('data/example.csv')
    csv = CSV.parse(csv_text, :headers => true)
  end

  def valid_csv? (file_path)
    return true
  end

end
