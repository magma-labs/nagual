require 'nagual/util/configuration'
require 'nagual/conversion/field_validation'

module Nagual
  module Conversion
    class ProductContract
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
          type = fields[key.to_s] || 'string'
          validate(key, value, type)
        end.compact
      end

      def find_required_errors(row)
        required.map do |key, _value|
          validate(key, row[key], 'required')
        end.compact
      end

      def validate(key, value, type)
        type_validation = FieldValidation.new(value, type)

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
