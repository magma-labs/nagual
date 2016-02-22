require 'nagual/conversion/field_validation'

module Nagual
  module Conversion
    class ProductContract
      attr_reader :errors

      def initialize(row, required, definition)
        @errors     = []
        @required   = required
        @definition = definition
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
          type = @definition[key.to_s] || 'string'
          validate(key, value, type)
        end.compact
      end

      def find_required_errors(row)
        @required.map do |key, _value|
          validate(key, row[key], 'required')
        end.compact
      end

      def validate(key, value, type)
        type_validation = FieldValidation.new(value, type)

        unless type_validation.valid?
          "#{key} is invalid. #{type_validation.error}"
        end
      end
    end
  end
end
