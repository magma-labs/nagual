module Nagual
  module Conversion
    class ProductDecoration
      def initialize(row, config)
        @row    = row
        @config = config
      end

      def build
        @row.merge(fixed).merge(copied).merge(merged).merge(images)
      end

      private

      def images
        config = @config['images'].find do |params|
          @row[params['filter_key']] == params['filter_value']
        end

        img_hash = config ? { config['view_type'] => config['names'] } : {}

        { 'images' => img_hash }
      end

      def fixed
        @config['fixed']
      end

      def copied
        @config['copy']
          .select { |copy| @row[copy['key']] }
          .map    { |copy| [copy['to'], @row[copy['key']]] }
          .to_h
      end

      def merged
        @config['merge'].map do |merge|
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
