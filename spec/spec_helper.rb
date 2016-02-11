require 'simplecov'
require 'logger'
SimpleCov.start

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

class NullLogger < Logger
  def initialize(*args)
  end

  def add(*args, &block)
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    #Nagual::Logging.logger = NullLogger.new
  end
end
