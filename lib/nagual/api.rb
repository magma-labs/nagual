require 'nagual/configuration'
require 'nagual/logging'
require 'nagual/xml/catalog'
require 'nagual/csv/input'
require 'nagual/models/catalog'

module Nagual
  class API
    include Nagual::Logging
    include Nagual::Configuration

    def review(input_path)
      logger.debug('API') { "CSV::Input to be created for #{input_path}" }
      input  = CSV::Input.new(input_path)
      report = "#{input.valid_products.count} valid products\n"

      add_invalid_information(report, input.invalid_products)
      report
    end

    def export(input_path)
      logger.debug('API') { "CSV::Input to be created for #{input_path}" }
      input = CSV::Input.new(input_path)
      catalog = Models::Catalog.new(input.valid_products)

      XML::Catalog.new(catalog).output
    end

    private

    def add_invalid_information(report, invalid_products)
      report << "#{invalid_products.count} invalid products\n"
      report << "Errors:\n"
      invalid_products.each do |product|
        report << "id: #{product.product_id} | errors: #{product.errors}\n"
      end
    end
  end
end
