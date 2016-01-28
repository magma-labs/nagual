require 'rspec/core/rake_task'
require 'nagual'

RSpec::Core::RakeTask.new(:spec)

task :catalog do
  File.open(Configuration.properties['output_file'], 'w') do |file|
    file.write(Nagual.catalog)
  end
end
