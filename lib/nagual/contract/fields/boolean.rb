module Nagual
  module Contract
    module Fields
      class Boolean < Base
        def valid?
          %w(true false).include?(@value)
        end

        def error
          'boolean expects values: true or false'
        end
      end
    end
  end
end
