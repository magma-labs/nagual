module Nagual
  class Reader
    def read
      raise NotImplementedError, 'Ask the subclass'
    end
  end
end
