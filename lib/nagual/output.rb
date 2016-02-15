require 'nagual/output/xml_catalog'
require 'nagual/output/error_report'

module Nagual
  module Output
    def self.to(destination)
      name = destination.to_s.split('_').map(&:capitalize).join
      Output.const_get(name).new
    end
  end
end
