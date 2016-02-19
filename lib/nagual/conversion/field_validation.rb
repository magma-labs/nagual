require 'nagual/conversion/fields/base'
require 'nagual/conversion/fields/boolean'
require 'nagual/conversion/fields/decimal'
require 'nagual/conversion/fields/integer'
require 'nagual/conversion/fields/priority'
require 'nagual/conversion/fields/frequency'
require 'nagual/conversion/fields/datetime'
require 'nagual/conversion/fields/required'

module Nagual
  module Conversion
    class FieldValidation
      include Fields

      FIELD = {
        priority: Priority, string: Base, boolean: Boolean, decimal: Decimal,
        int: Integer, frequency: Frequency, datetime: Datetime,
        required: Required
      }.freeze

      def initialize(value, type)
        base, max_size = type.split('.')

        @value    = value
        @max_size = max_size ? max_size.to_i : 4000
        contract  = FIELD[base.to_sym] || Base
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
