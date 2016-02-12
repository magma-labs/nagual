module Nagual
  module Contract
    module Fields
      class Decimal < Base
        def valid?
          !Float(@value).nil?
        rescue
          false
        end

        def error
          'decimal expects float format'
        end
      end
    end
  end
end
