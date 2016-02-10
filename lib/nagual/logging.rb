require 'logger'

module Nagual
  module Logging
    def logger
      Nagual.logger
    end

    def self.default
      Logger.new(STDOUT)
    end
  end
end
