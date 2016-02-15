require 'nagual/output/xml_catalog'
require 'nagual/output/error_report'

module Nagual
  module Output
    def self.to(destination)
      case destination
      when :catalog_xml
        Output::XMLCatalog.new
      when :error_report
        Output::ErrorReport.new
      else
        fail 'destination not implemented'
      end
    end
  end
end
