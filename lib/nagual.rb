project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual
  def self.run
    File.open(Configuration.properties['output_file'], 'w') do |file|
      csv_input = File.read(Configuration.properties['input_file'])
      products  = Input.new(csv_input).products

      file.write(Catalog.new(products).output)
    end
  end
end
