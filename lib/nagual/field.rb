require 'nagual/field_contracts'

module Nagual
  class Field
    CONTRACT = {
      priority: Priority, string: Contract, boolean: Boolean, decimal: Decimal,
      int: Integer, frequency: Frequency, datetime: Datetime, required: Required
    }.freeze

    def initialize(value, type)
      base, max_size = type.split('.')

      @value    = value
      @max_size = max_size ? max_size.to_i : 4000
      contract  = CONTRACT[base.to_sym] || Contract
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
