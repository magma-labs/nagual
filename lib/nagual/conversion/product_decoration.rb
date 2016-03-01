module Nagual
  module Conversion
    class ProductDecoration
      def initialize(row, params)
        @row    = row
        @params = params
      end

      def build
        @row.merge(fixed).merge(copied).merge(merged).merge(images)
      end

      private

      def images
        @params['images'].map do |params|
          if @row[params['filter_key']] == params['filter_value']
            ['images', { params['view_type'] => params['names'] }]
          else
            ['images', {}]
          end
        end.to_h
      end

      def fixed
        @params['fixed']
      end

      def copied
        @params['copy']
          .select { |copy| @row[copy['key']] }
          .map    { |copy| [copy['to'], @row[copy['key']]] }
          .to_h
      end

      def merged
        @params['merge'].map do |merge|
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
    end
  end
end
