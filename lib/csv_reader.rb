require 'csv'

class CSVReader

  def read_csv_file
    csv_text = File.read('data/example.csv')
    csv = CSV.parse(csv_text, :headers => true)
  end

end
