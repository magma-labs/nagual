require 'nagual/contract/fields'

module Nagual
  module Contract
    class Validation
      FIELD = {
        priority: Fields::Priority, string: Fields::Base,
        boolean: Fields::Boolean, decimal: Fields::Decimal,
        int: Fields::Integer, frequency: Fields::Frequency,
        datetime: Fields::Datetime, required: Fields::Required
      }.freeze

      def initialize(value, type)
        base, max_size = type.split('.')

        @value    = value
        @max_size = max_size ? max_size.to_i : 4000
        contract  = FIELD[base.to_sym] || Fields::Base
        @contract = contract.new(value)
      end

      def valid?
        @contract.valid? && valid_size?
      end

      def error
        return 'field exceeds max size' unless valid_size?
        valid? ? '' : @contract.error
      end

      private

      def valid_size?
        return true if @value.nil?
        @max_size >= @value.size
      end
    end
  end
end
