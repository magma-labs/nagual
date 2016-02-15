require 'nagual/mapping/base'

module Nagual
  module Mapping
    class Images < Base
      def transform
        images = @row[images_name.to_sym] || ''
        images.split(',')
      end

      private

      def images_name
        config['mapping']['product']['images']
      end
    end
  end
end
