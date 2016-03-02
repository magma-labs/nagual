module Nagual
  module Conversion
    class ProductDecoration
      def initialize(row, config)
        @row    = row
        @config = config
      end

      def build
        [fixed, copied, merged, images, variations]
          .inject(@row, &:merge)
          .reject { |key, _| @config['variations'].include?(key) }
      end

      private

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

      def images
        config = @config['images'].find do |params|
          @row[params['filter_key']] == params['filter_value']
        end

        config ? { 'images' => { config['view_type'] => config['names'] } } : {}
      end

      def variations
        variations = @config['variations'].map do |variation_key|
          if @row[variation_key] && !@row[variation_key].empty?
            { id: variation_key, values: @row[variation_key].split(',') }
          end
        end.compact

        variations.empty? ? {} : { 'variations' => variations }
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
