project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual
  def self.run
    File.open(Configuration.properties['output_file'], 'w') do |file|
      csv   = File.read(Configuration.properties['input_file'])
      input = Input.new(csv_input)

      file.write(Catalog.new(input).output)
    end
  end
end
