module Nagual
  class Field
    class Default
      def initialize(value)
      end

      def valid?
        true
      end
    end

    class Decimal
      def initialize(value)
        @value = value
      end

      def valid?
        !Float(@value).nil?
      rescue
        false
      end

      def error
        'decimal expects float format'
      end
    end

    class Priority
      def initialize(value)
        @value = value
      end

      def valid?
        !Float(@value).nil? && @value.to_f <= 1.0 && @value.to_f >= 0.0
      rescue
        false
      end

      def error
        'priority expects float between 0.0 and 1.0'
      end
    end

    class Boolean
      def initialize(value)
        @value = value
      end

      def valid?
        %w(TRUE FALSE).include?(@value)
      end

      def error
        'boolean expects values: TRUE or FALSE'
      end
    end

    class Integer
      def initialize(value)
        @value = value
      end

      def valid?
        !Integer(@value).nil?
      rescue
        false
      end

      def error
        'int expects integer format'
      end
    end

    class Frequency
      VALUES = %w(always hourly daily weekly monthly yearly never).freeze

      def initialize(value)
        @value = value
      end

      def valid?
        VALUES.include?(@value)
      end

      def error
        "frequency expects values: #{VALUES}"
      end
    end

    class Datetime
      def initialize(value)
        @value = value
      end

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
