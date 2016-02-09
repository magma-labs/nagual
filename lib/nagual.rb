require 'nagual/configuration'
require 'nagual/xml/catalog'
require 'nagual/csv/input'
require 'nagual/catalog'

module Nagual
  class << self
    def review(input_path)
      input = CSV::Input.new(input_path)
      report = "#{input.valid_products.count} valid products\n"
      add_invalid_information(report, input.invalid_products)
      report
    end

    def export(input_path)
      input = CSV::Input.new(input_path)
      catalog = Catalog.new(input.valid_products)
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
