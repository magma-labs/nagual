project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual

  def self.run
    input      = File.read(Configuration.properties['csv_file'])
    output     = Configuration.properties['xml_file']
    attributes = Configuration.properties['attributes']

    File.open(output, 'w') do |file|
      csv_content = CSV.new(input).to_hash
      file.write(XML.new('catalog', 'product', attributes, csv_content).build)
    end
  end

end
