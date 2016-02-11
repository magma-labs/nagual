require 'logger'

module Nagual
  module Logging
    def logger
      @@logger ||= create_logger
    end

    def self.logger=(logger)
      @@logger = logger
    end

    private

    def create_logger
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      logger.formatter = proc do |severity, datetime, _progname, msg|
        date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
        "[#{date_format}] #{severity} (#{self.class}): #{msg}\n"
      end
      logger
    end
  end
end
