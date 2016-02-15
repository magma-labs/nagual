require 'spec_helper'
require 'nagual/mapping/product'

RSpec.describe Nagual::Mapping::Product do
  subject { described_class.new(row) }

  context 'with mapped values' do
    let(:row) { { id: 'id' } }

    it 'has no errors' do
      expect(subject.transform).to eq('product_id' => 'id')
    end
  end

  context 'with not mapped values' do
    let(:row) { { 'non-existent': 'value' } }

    it 'has no errors' do
      expect(subject.transform).to eq({})
    end
  end
end
