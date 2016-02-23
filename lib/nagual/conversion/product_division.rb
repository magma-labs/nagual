require 'nagual/util/configuration'

module Nagual
  module Conversion
    class ProductDivision
      include Nagual::Configuration

      def initialize(row, strategy, params)
        @row      = row
        @strategy = strategy
        @params   = params
      end

      def split
        case @strategy
        when 'none'      then [@row]
        when 'variation' then build_from_variations
        end
      end

      private

      def build_from_variations
        variations.map do |variation|
          row = base_row(variation)
          row.merge('product_id' => @params['pattern'] % symbolize_keys(row))
        end
      end

      def base_row(variation)
        @row.dup
            .tap { |row| row.delete(@params['variations']) }
            .merge(@params['variation'] => variation)
      end

      def symbolize_keys(row)
        row.map { |k, v| [k.to_sym, v] }.to_h
      end

      def variations
        @row[@params['variations']]
      end
    end
  end
end
