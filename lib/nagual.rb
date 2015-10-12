project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual
  def self.run
    File.open(Configuration.properties['output_file'], 'w') do |file|
      csv_input = File.read(Configuration.properties['input_file'])
      file.write(Catalog.new(csv_input).to_xml)
    end
  end
end
