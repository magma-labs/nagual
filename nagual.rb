Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|f| require f}

input  = Configuration.properties['csv_file']
output = Configuration.properties['xml_file']
reader = Object.const_get(Configuration.properties['reader'])
writer = Object.const_get(Configuration.properties['writer'])

File.open(output, 'w') do |file|
  csv_content = reader.new(input).read
  xml_content = writer.new(csv_content).write

  file.write(xml_content)
end
