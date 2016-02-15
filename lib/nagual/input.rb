module Nagual
  module Input
    def self.from(origin)
      fail 'Origin not implemented' unless origin == :csv
      Input::CSV.new
    end
  end
end
