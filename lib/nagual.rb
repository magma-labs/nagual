require 'nagual/api'
require 'nagual/logging'

module Nagual
  def self.logger
    @logger ||= Nagual::Logging.default
  end

  def self.logger=(logger)
    @logger = logger
  end
end
