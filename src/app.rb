require 'csv'

csv_text = File.read('data/example.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  puts row
end
