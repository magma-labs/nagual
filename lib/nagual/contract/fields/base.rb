module Nagual
  module Contract
    module Fields
      class Base
        def initialize(value)
          @value = value
        end

        def valid?
          true
        end

        def error
        end
      end
    end
  end
end
