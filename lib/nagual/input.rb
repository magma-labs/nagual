module Nagual
  module Input
    def self.from(origin)
      Input.const_get(origin.to_s.upcase).new
    end
  end
end
