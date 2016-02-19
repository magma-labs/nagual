require 'nagual/conversion/catalog'

module Nagual
  module Conversion
    def self.for(type)
      Conversion.const_get(type.to_s.capitalize).new
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
