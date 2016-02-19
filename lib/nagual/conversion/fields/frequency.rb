module Nagual
  module Conversion
    module Fields
      class Frequency < Base
        VALUES = %w(always hourly daily weekly monthly yearly never).freeze

        def valid?
          VALUES.include?(@value)
        end

        def error
          "frequency expects values: #{VALUES}"
        end
      end
    end
  end
end
