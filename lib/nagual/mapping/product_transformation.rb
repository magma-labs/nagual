require 'nagual/mapping/product/product'
require 'nagual/mapping/product/product_variations'
require 'nagual/mapping/product/images'
require 'nagual/contract/product'
require 'nagual/models/product'

module Nagual
  module Mapping
    class ProductTransformation
      def initialize(rows)
        @rows   = rows
        @result = Result.new
      end

      def parse
        @rows.each_with_index do |row, index|
          product_fields = Mapping::Product.new(row).transform
          contract       = Contract::Product.new(product_fields)

          if contract.valid?
            @result.objects << create_product(product_fields, row)
          else
            @result.errors << { index: index + 1, errors: contract.errors }
          end
        end

        @result
      end

      def create_product(fields, row)
        Models::Product.new(
          attributes: fields,
          variations: Mapping::ProductVariations.new(row).transform,
          images:     Mapping::Images.new(row).transform)
      end
    end
  end
end
