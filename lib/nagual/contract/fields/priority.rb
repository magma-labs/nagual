module Nagual
  module Contract
    module Fields
      class Priority < Base
        def valid?
          !Float(@value).nil? && @value.to_f <= 1.0 && @value.to_f >= 0.0
        rescue
          false
        end

        def error
          'priority expects float between 0.0 and 1.0'
        end
      end
    end
  end
end
