require 'nagual/util/logging'
require 'nagual/util/configuration'

require 'nagual/conversion/product_mapping'
require 'nagual/conversion/product_decoration'
require 'nagual/conversion/product_division'
require 'nagual/conversion/product_contract'

module Nagual
  module Conversion
    class Catalog
      include Nagual::Logging
      include Nagual::Configuration

      def parse(rows)
        result = Result.new
        rows
          .map { |row| mappings(row) }
          .map { |row| decorate(row) }
          .map { |row| split(row) }.flatten
          .each { |row| validate(row, result) }

        result
      end

      private

      def mappings(row)
        debug("Row to be mapped: #{row}")
        mutations = config['mapping']['product']['mutations']
        ProductMapping.new(row, mutations).transform
      end

      def decorate(row)
        configuration = config['decoration']['product']
        ProductDecoration.new(row, configuration).build
      end

      def split(row)
        strategy = config['division']['product']['strategy']
        params   = config['division']['product']['params']
        ProductDivision.new(row, strategy, params).split
      end

      def build_contract(row)
        required   = config['contract']['product']['required']
        definition = config['contract']['product']['fields']
        ProductContract.new(row, required, definition)
      end

      def validate(row, result)
        debug("Row to be validated: #{row}")
        product_id = row['product_id']
        contract   = build_contract(row)

        if contract.valid?
          info("#{product_id} follows product contract")
          result.objects << create_product(row)
        else
          warn("#{product_id} has the following errors: #{contract.errors}")
          result.errors << { id: product_id, errors: contract.errors }
        end
      end

      def create_product(row)
        images     = row.delete('images') || {}
        variations = row.delete('variations') || []

        debug("Product to be created with row: #{row}, images: #{images}, "\
              "variations: #{variations}")
        Models::Product.new(attributes: row, images: images,
                            variations: variations)
      end
    end
  end
end
