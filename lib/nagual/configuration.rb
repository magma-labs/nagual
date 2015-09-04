require 'yaml'

module Nagual
  module Configuration
    def self.properties
      path = File.join(File.dirname(__FILE__), '../..',
                       'config/configuration.yml')
      YAML.load_file(path)
    end
  end
end
