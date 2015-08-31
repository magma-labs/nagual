project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual

  def self.run
    input      = File.read(Configuration.properties['csv_file'])
    output     = Configuration.properties['xml_file']
    reader     = Object.const_get(Configuration.properties['reader'])
    writer     = Object.const_get(Configuration.properties['writer'])
    attributes = {xmlns: 'http://www.demandware.com/xml/impex/catalog/2006-10-31'}

    File.open(output, 'w') do |file|
      csv_content = reader.new(input).read
      writer      = writer.new('catalog', 'product', attributes, csv_content)

      file.write(writer.write)
    end
  end

end
