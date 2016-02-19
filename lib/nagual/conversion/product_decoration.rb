require 'nagual/util/configuration'

module Nagual
  module Conversion
    class ProductDecoration
      include Nagual::Configuration

      def initialize(row)
        @row = row
      end

      def build
        @row.merge(fixed_values)
      end

      private

      def fixed_values
        config['decoration']['product']['values']
      end
    end
  end
end
