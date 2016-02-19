require 'spec_helper'
require 'nagual/util/configuration'

RSpec.describe Nagual::Configuration do
  subject { Class.new.include(described_class).new }

  it 'contains configuration properties' do
    expect(subject.config).not_to be_empty
  end
end
