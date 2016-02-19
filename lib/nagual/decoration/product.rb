require 'nagual/configuration'

module Nagual
  module Decoration
    class Product
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
