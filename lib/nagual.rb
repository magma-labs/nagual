project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual

  def self.run
    products_path = Configuration.properties['products_file']
    output_path   = Configuration.properties['output_file']

    File.open(output_path, 'w') do |file|
      file.write(Catalog.new(products_path).to_xml)
    end
  end

end
