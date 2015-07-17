require 'yaml'

module Configuration
  def Configuration.properties
    path = File.join(File.dirname(__FILE__), "..", "config/configuration.yml")
    YAML.load_file(path)
  end
end
