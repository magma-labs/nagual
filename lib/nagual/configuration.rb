require 'yaml'

module Nagual
  module Configuration
    def config
      @config ||= load_config_from_file
    end

    def load_config_from_file
      path = File.join('./config/configuration.yml')
      YAML.load_file(path)
    end
  end
end
