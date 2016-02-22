require 'nagual/util/configuration'

module Nagual
  module Conversion
    class ProductDecoration
      include Nagual::Configuration

      def initialize(row)
        @row = row
      end

      def build
        @row.merge(fixed_values).merge(copied_values).merge(merge_values)
      end

      private

      def fixed_values
        product_config['fixed']
      end

      def copied_values
        product_config['copy']
          .select { |copy| @row[copy['key']] }
          .map    { |copy| [copy['to'], @row[copy['key']]] }
          .to_h
      end

      def merge_values
        product_config['merge'].map do |merge|
          values = prepare_values(merge['keys'])
          [merge['to'], merge['pattern'] % values] unless values.empty?
        end.compact.to_h
      end

      def prepare_values(keys)
        @row
          .select { |key, _| keys.include?(key) }
          .map    { |key, value| [key.to_sym, value] }
          .to_h
      end

      def product_config
        config['decoration']['product']
      end
    end
  end
end
