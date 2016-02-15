require 'nagual/configuration'

module Nagual
  module Mapping
    class Base
      include Nagual::Configuration

      def initialize(row)
        @row = row
      end

      private

      def transform
      end
    end
  end
end
