require 'logger'
require 'nagual/configuration'

module Nagual
  module Logging
    include Nagual::Configuration

    def debug(message)
      log('DEBUG', message)
    end

    def info(message)
      log('INFO', message)
    end

    def warn(message)
      log('WARN', message)
    end

    def error(message)
      log('ERROR', message)
    end

    private

    def log(level, message)
      logger.add(Logger.const_get(level), message, self.class.name)
    end

    def logger
      @@logger ||= create_logger
    end

    def create_logger
      logger = Logger.new(File.new(config['log']['file'], 'a'))
      logger.level = Logger.const_get config['log']['level']
      logger.formatter = proc do |severity, datetime, progname, msg|
        date_format = datetime.strftime(config['log']['date_format'])
        "[#{date_format}] #{severity} [#{progname}]: #{msg}\n"
      end
      logger
    end
  end
end
