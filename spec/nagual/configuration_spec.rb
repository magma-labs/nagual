require 'spec_helper'

RSpec.describe Nagual::Configuration do

  it 'contains configuration properties' do
    expect(subject.properties).not_to be_empty
  end

end