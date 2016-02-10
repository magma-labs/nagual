require 'spec_helper'
require 'nagual/logging'

RSpec.describe Nagual::Logging do
  context 'included' do
    subject { Class.new.include(described_class).new }

    it 'responds to logger' do
      expect(subject.logger).to respond_to(:info)
    end
  end
end
