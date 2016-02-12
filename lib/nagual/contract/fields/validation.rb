require 'nagual/contract/fields/base'
require 'nagual/contract/fields/boolean'
require 'nagual/contract/fields/decimal'
require 'nagual/contract/fields/integer'
require 'nagual/contract/fields/priority'
require 'nagual/contract/fields/frequency'
require 'nagual/contract/fields/datetime'
require 'nagual/contract/fields/required'

module Nagual
  module Contract
    module Fields
      class Validation
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
end
