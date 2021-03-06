require 'nagual/util/configuration'

module Nagual
  module Output
    class ErrorReport
      include Nagual::Configuration

      def write!(objects, errors)
        File.open(config['output']['error_report']['file'], 'w') do |file|
          file.write(write(objects, errors))
        end
      end

      def write(objects, errors)
        report = "Correct objects read from file: #{objects.count}\n"
        report << "Errors found: #{errors.count}\n"
        report << "Errors:\n"
        errors.each do |error|
          report << "id: #{error[:id]} | errors: #{error[:errors]}\n"
        end
        report
      end
    end
  end
end
