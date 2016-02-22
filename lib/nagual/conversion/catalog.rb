require 'nagual/util/logging'
require 'nagual/util/configuration'

require 'nagual/conversion/product_mapping'
require 'nagual/conversion/variations_mapping'
require 'nagual/conversion/images_mapping'
require 'nagual/conversion/product_decoration'
require 'nagual/conversion/product_contract'

module Nagual
  module Conversion
    class Catalog
      include Nagual::Logging
      include Nagual::Configuration

      def parse(rows)
        result = Result.new
        fields = rows
                 .map { |row| ProductMapping.new(row).transform }
                 .map { |row| ProductDecoration.new(row).build }
                 .map { |row| ProductDivision.new(row, division_strategy, {}).split }

        fields.each_with_index { |row, i| validate(row, rows[i], result) }
        result
      end

      private

      def validate(fields, row, result)
        contract   = ProductContract.new(fields)
        product_id = fields['product_id']

        debug("Product fields: #{fields}")
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

        debug("Variations: #{variations}, Images: #{images}")
        Models::Product.new(attributes: attributes, variations: variations,
                            images: images)
      end

      def division_strategy
        config['division']['product']['strategy']
      end
    end
  end
end
