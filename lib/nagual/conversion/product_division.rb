require 'nagual/util/configuration'

module Nagual
  module Conversion
    class ProductDivision
      include Nagual::Configuration

      def initialize(row, strategy, _params)
        @row      = row
        @strategy = strategy
      end

      def split
        @row if @strategy == 'none'
      end
    end
  end
end
