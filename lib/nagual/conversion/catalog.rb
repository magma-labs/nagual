require 'nagual/util/logging'
require 'nagual/util/configuration'

require 'nagual/conversion/product_mapping'
require 'nagual/conversion/variations_mapping'
require 'nagual/conversion/images_mapping'
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
          .each_with_index { |row, i| validate(row, rows[i], result) }

        result
      end

      private

      def mappings(row)
        debug("Row to be mapped: #{row}")
        mutations = config['mapping']['product']['mutations']
        ProductMapping.new(row, mutations).transform
      end

      def decorate(row)
        debug("Row to be decorated: #{row}")
        configuration = config['decoration']['product']
        ProductDecoration.new(row, configuration).build
      end

      def split(row)
        debug("Row to be splitted: #{row}")
        strategy = config['division']['product']['strategy']
        params   = config['division']['product']['params']
        ProductDivision.new(row, strategy, params).split
      end

      def build_contract(fields)
        required   = config['contract']['product']['required']
        definition = config['contract']['product']['fields']
        ProductContract.new(fields, required, definition)
      end

      def validate(fields, row, result)
        debug("Row to be validated: #{row}")
        product_id = fields['product_id']
        contract   = build_contract(fields)

        if contract.valid?
          info("#{product_id} follows product contract")
          result.objects << create_product(fields, row)
        else
          warn("#{product_id} has the following errors: #{contract.errors}")
          result.errors << { id: product_id, errors: contract.errors }
        end
      end

      def create_product(attributes, row)
        variations = VariationsMapping.new(row).transform
        images     = ImagesMapping.new(row).transform

        debug("Product to be created with attributes: #{attributes},"\
              " images: #{images}, variations: #{variations}")
        Models::Product.new(attributes: attributes, variations: variations,
                            images: images)
      end
    end
  end
end
