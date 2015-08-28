project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual

  def self.run
    input  = File.read(Configuration.properties['csv_file'])
    output = Configuration.properties['xml_file']
    reader = Object.const_get(Configuration.properties['reader'])
    writer = Object.const_get(Configuration.properties['writer'])

    File.open(output, 'w') do |file|
      csv_content = reader.new(input).read
      xml_content = writer.new(csv_content).write

      file.write(xml_content)
    end
  end

end
