module Nagual
  module Conversion
    module Fields
      class Datetime < Base
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
