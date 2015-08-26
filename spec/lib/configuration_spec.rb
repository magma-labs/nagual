require 'spec_helper'
require 'configuration'

RSpec.describe Configuration do

  it 'contains configuration properties' do
    expect(subject.properties).not_to be_empty
  end

end
