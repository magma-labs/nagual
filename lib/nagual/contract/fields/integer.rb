module Nagual
  module Contract
    module Fields
      class Integer < Base
        def valid?
          !Integer(@value).nil?
        rescue
          false
        end

        def error
          'int expects integer format'
        end
      end
    end
  end
end
