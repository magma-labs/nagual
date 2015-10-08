require 'spec_helper'

RSpec.describe Nagual::Input do
  it 'loads a csv file' do
    expect(described_class.load('products', 'data_examples')).not_to be_empty
  end
end
