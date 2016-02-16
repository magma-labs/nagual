require 'spec_helper'
require 'nagual/logging'

RSpec.describe Nagual::Logging do
  context 'included' do
    subject { Class.new.include(described_class).new }

    it 'responds to logger methods' do
      subject.debug('works')
      subject.info('works')
      subject.warn('works')
      subject.error('works')
    end
  end
end
