module Nagual
  module Output
    class ErrorReport
      include Nagual::Logging

      def write!(objects, errors)
        report = "Correct objects read from file: #{objects.count}\n"
        report << "Errors found: #{errors.count}\n"
        report << "Errors:\n"
        errors.each do |error|
          report << "row ##{error[:index]} | errors: #{error[:errors]}\n"
        end
        report
      end
    end
  end
end
