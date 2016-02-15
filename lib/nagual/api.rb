require 'nagual/configuration'
require 'nagual/logging'
require 'nagual/output/xml_catalog'
require 'nagual/input/csv'
require 'nagual/mapping/product'
require 'nagual/mapping/product_variations'
require 'nagual/mapping/images'
require 'nagual/contract/product'
require 'nagual/models/catalog'

module Nagual
  class API
    include Nagual::Logging
    include Nagual::Configuration

    def review(input_path)
      logger.debug('API') { "Input to be created for #{input_path}" }
      input  = Input::CSV.new(input_path)
      report = "Rows read from file: #{input.rows.count}\n"
      _, errors = convert(input)
      add_invalid_information(report, errors)
      report
    end

    def export(input_path)
      logger.debug('API') { "Input to be created for #{input_path}" }
      input = Input::CSV.new(input_path)
      products, = convert(input)
      catalog = Models::Catalog.new(products)

      Output::XMLCatalog.new(catalog).read
    end

    private

    def convert(input)
      errors = []
      products = []

      input.rows.each_with_index do |row, index|
        product_fields = Mapping::Product.new(row).transform
        contract       = Contract::Product.new(product_fields)

        if contract.valid?
          products << create_product(product_fields, row)
        else
          errors << { index: index + 1, errors: contract.errors }
        end
      end

      [products, errors]
    end

    def create_product(fields, row)
      Models::Product.new(
        attributes: fields,
        variations: Mapping::ProductVariations.new(row).transform,
        images:     Mapping::Images.new(row).transform)
    end

    def add_invalid_information(report, errors)
      report << "Errors found: #{errors.count}\n"
      report << "Errors:\n"
      errors.each do |error|
        report << "row ##{error[:index]} | errors: #{error[:errors]}\n"
      end
    end
  end
end
