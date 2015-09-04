project_root = File.dirname(File.absolute_path(__FILE__)) + '/nagual/*'
Dir.glob(project_root, &method(:require))

module Nagual
  def self.run
    File.open(Configuration.properties['output_file'], 'w') do |file|
      file.write(Catalog.new.to_xml)
    end
  end
end
