require 'csv'
require 'reader'
require 'configuration'

class CSVReader < Reader

  def read
    path = Configuration.properties["csv_file"]
    csv_text =  File.read(path)
    CSV.parse(csv_text, :headers => true)
  end

  def valid_csv? (file_path)
    return true
  end

end
