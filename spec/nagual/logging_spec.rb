require 'spec_helper'
require 'nagual/logging'

RSpec.describe Nagual::Logging do
  context 'module' do
    it 'returns a default logger' do
      expect(described_class.default).to respond_to(:info)
    end
  end

  context 'included' do
    subject { Class.new.include(described_class).new  }

    it 'responds to logger' do
      expect(subject.logger).to respond_to(:info)
    end
  end
end
