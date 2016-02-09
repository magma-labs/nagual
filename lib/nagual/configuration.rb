require 'yaml'

module Nagual
  module Configuration
    def self.properties
      path = File.join('./config/configuration.yml')
      YAML.load_file(path)
    end
  end
end
