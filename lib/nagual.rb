project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual

  def self.run
    input_path  = File.read(Configuration.properties['csv_file'])
    output_path = Configuration.properties['xml_file']

    File.open(output_path, 'w') do |file|
      file.write(Catalog.new(input_path).to_xml)
    end
  end

end
