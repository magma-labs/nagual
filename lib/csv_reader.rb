require 'csv'
require 'reader'
require 'configuration'

class CSVReader < Reader

  def read
    rows = Array.new
    path = Configuration.properties["csv_file"]
    CSV.foreach(path, :headers => true) do |row|
       rows << row
    end
    return rows
  end

end
