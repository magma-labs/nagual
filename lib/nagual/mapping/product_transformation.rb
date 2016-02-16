require 'nagual/mapping/product/product'
require 'nagual/mapping/product/product_variations'
require 'nagual/mapping/product/images'
require 'nagual/contract/product'
require 'nagual/models/product'
require 'nagual/logging'

module Nagual
  module Mapping
    class ProductTransformation
      include Nagual::Logging

      def initialize(rows)
        @rows   = rows
        @result = Result.new
      end

      def parse
        @rows.each_with_index do |row, index|
          debug("##{index + 1} Fields to be parsed: #{row}")
          product_fields = Mapping::Product.new(row).transform

          validate(row, index + 1, product_fields)
        end

        @result
      end

      private

      def validate(row, row_index, product_fields)
        debug("##{row_index} Product fields: #{product_fields}")
        contract = Contract::Product.new(product_fields)

        if contract.valid?
          info("##{row_index} follows product contract")
          @result.objects << create_product(product_fields, row)
        else
          warn("##{row_index} has the following errors: #{contract.errors}")
          @result.errors << { index: row_index, errors: contract.errors }
        end
      end

      def create_product(fields, row)
        variations = Mapping::ProductVariations.new(row).transform
        images     = Mapping::Images.new(row).transform

        debug('Creating product with the following data'\
              "=> Fields: #{fields}, Variations: #{variations},"\
              "Images: #{images}")

        Models::Product.new(attributes: fields, variations: variations,
                            images: images)
      end
    end
  end
end
