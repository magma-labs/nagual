require 'csv'
require 'nagual/models/product'
require 'nagual/configuration'
require 'nagual/logging'

module Nagual
  module Input
    class CSV
      include Nagual::Logging
      include Nagual::Configuration

      attr_reader :rows

      def initialize(file)
        logger.info('Input::CSV') { "Opening #{file} to read csv content" }
        content = File.read(file)
        @rows   = parse(content)
      end

      private

      def parse(content)
        column_names, *rows = *::CSV.parse(content, headers: true)
        logger.debug('Input::CSV') { "Column names extracted: #{column_names}" }
        rows.map { |row| Hash[column_names.zip(row)] }
      end
    end
  end
end
