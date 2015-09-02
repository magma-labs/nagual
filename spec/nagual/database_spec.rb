require 'spec_helper'

RSpec.describe Nagual::Database do

  before do
  end

  it 'loads a csv file' do
    described_class.load('tests')
  end

end
