require 'nagual/mapping/product_transformation'

module Nagual
  module Mapping
    def self.parse(rows)
      ProductTransformation.new(rows).parse
    end

    class Result
      attr_accessor :objects, :errors

      def initialize
        @objects = []
        @errors  = []
      end
    end
  end
end
