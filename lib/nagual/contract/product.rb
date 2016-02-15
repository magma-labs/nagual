require 'nagual/configuration'
require 'nagual/contract/fields/validation'

module Nagual
  module Contract
    class Product
      include Nagual::Configuration

      attr_reader :errors

      def initialize(row)
        @errors = []
        validate_row(row)
      end

      def valid?
        @errors.empty?
      end

      private

      def validate_row(row)
        errors =  find_required_errors(row)
        errors += find_type_errors(row)

        @errors += errors
      end

      def find_type_errors(row)
        row.map do |key, value|
          validate(key, value, fields[key.to_s])
        end.compact
      end

      def find_required_errors(row)
        required.map do |key, _value|
          validate(key, row[key.to_sym], 'required')
        end.compact
      end

      def validate(key, value, type)
        type_validation = Contract::Fields::Validation.new(value, type)

        unless type_validation.valid?
          "#{key} is invalid. #{type_validation.error}"
        end
      end

      def required
        config['contract']['product']['required']
      end

      def fields
        config['contract']['product']['fields']
      end
    end
  end
end
