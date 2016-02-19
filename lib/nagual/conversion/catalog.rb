require 'nagual/logging'
require 'nagual/conversion/product_mapping'
require 'nagual/conversion/variations_mapping'
require 'nagual/conversion/images_mapping'
require 'nagual/conversion/product_decoration'
require 'nagual/conversion/product_contract'

module Nagual
  module Conversion
    class Catalog
      include Nagual::Logging

      def parse(rows)
        result = Result.new

        rows.each_with_index do |row, index|
          debug("##{index + 1} Fields to be parsed: #{row}")
          product_fields = ProductMapping.new(row).transform

          debug("##{index + 1} Mapped fields: #{row}")
          product_fields = ProductDecoration.new(product_fields).build

          debug("##{index + 1} Decorated fields: #{row}")
          validate(row, index + 1, product_fields, result)
        end

        result
      end

      private

      def validate(row, row_index, product_fields, result)
        debug("##{row_index} Product fields: #{product_fields}")
        contract = ProductContract.new(product_fields)

        if contract.valid?
          info("##{row_index} follows product contract")
          result.objects << create_product(product_fields, row)
        else
          warn("##{row_index} has the following errors: #{contract.errors}")
          result.errors << { index: row_index, errors: contract.errors }
        end
      end

      def create_product(fields, row)
        variations = VariationsMapping.new(row).transform
        images     = ImagesMapping.new(row).transform

        debug('Creating product with the following data'\
              "=> Fields: #{fields}, Variations: #{variations},"\
              "Images: #{images}")

        Models::Product.new(attributes: fields, variations: variations,
                            images: images)
      end
    end
  end
end
