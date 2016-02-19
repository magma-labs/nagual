module Nagual
  module Conversion
    module Fields
      class Required < Base
        def valid?
          !@value.nil? && !@value.empty?
        end

        def error
          'required expects non empty'
        end
      end
    end
  end
end
