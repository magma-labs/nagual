require 'csv'
require 'nagual/models/product'
require 'nagual/util/configuration'
require 'nagual/util/logging'

module Nagual
  module Input
    class CSV
      include Nagual::Logging
      include Nagual::Configuration

      def initialize
        file = config['input']['csv']['file']
        info("Opening #{file} to read csv content")

        @rows = File.read(file)
      end

      def read
        parse(@rows)
      end

      private

      def parse(content)
        column_names, *rows = *::CSV.parse(content, headers: true)
        debug("Column names extracted: #{column_names}")
        rows.map { |row| Hash[column_names.zip(row)] }
      end
    end
  end
end
