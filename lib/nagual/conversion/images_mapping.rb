require 'nagual/configuration'

module Nagual
  module Conversion
    class ImagesMapping
      include Nagual::Configuration

      def initialize(row)
        @row = row
      end

      def transform
        images = @row[images_name] || ''
        images.split(',')
      end

      private

      def images_name
        config['mapping']['product']['images']
      end
    end
  end
end
