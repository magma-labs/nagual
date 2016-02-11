require 'logger'
require 'nagual/configuration'

module Nagual
  module Logging
    include Nagual::Configuration

    def logger
      @@logger ||= create_logger
    end

    private

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
