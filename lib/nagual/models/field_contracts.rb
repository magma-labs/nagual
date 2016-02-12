module Nagual
  module Models
    class Field
      class Contract
        def initialize(value)
          @value = value
        end

        def valid?
          true
        end

        def error
        end
      end

      class Required < Contract
        def valid?
          !@value.nil? && !@value.empty?
        end

        def error
          'required expects non empty'
        end
      end

      class Decimal < Contract
        def valid?
          !Float(@value).nil?
        rescue
          false
        end

        def error
          'decimal expects float format'
        end
      end

      class Priority < Contract
        def valid?
          !Float(@value).nil? && @value.to_f <= 1.0 && @value.to_f >= 0.0
        rescue
          false
        end

        def error
          'priority expects float between 0.0 and 1.0'
        end
      end

      class Boolean < Contract
        def valid?
          %w(true false).include?(@value)
        end

        def error
          'boolean expects values: true or false'
        end
      end

      class Integer < Contract
        def valid?
          !Integer(@value).nil?
        rescue
          false
        end

        def error
          'int expects integer format'
        end
      end

      class Frequency < Contract
        VALUES = %w(always hourly daily weekly monthly yearly never).freeze

        def valid?
          VALUES.include?(@value)
        end

        def error
          "frequency expects values: #{VALUES}"
        end
      end

      class Datetime < Contract
        def valid?
          y, m, d = @value.split '-'
          Date.valid_date? y.to_i, m.to_i, d.to_i
        end

        def error
          'decimal expects float format'
        end
      end
    end
  end
end
