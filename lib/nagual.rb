project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual

  def self.run
    input      = File.read(Configuration.properties['csv_file'])
    output     = Configuration.properties['xml_file']
    attributes = Configuration.properties['attributes']

    File.open(output, 'w') do |file|
      csv_content = CSV.new(input).to_hash
      xml         = XML.new(csv_content, 'catalog', 'product', attributes)
      xml_content = xml.build([:'product-id'])

      file.write(xml_content)
    end
  end

end
