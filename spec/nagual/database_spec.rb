require 'spec_helper'

RSpec.describe Nagual::Database do

  it 'loads a csv file' do
    expect(described_class.load('tests')).not_to be_empty
  end

end
