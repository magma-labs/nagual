require 'spec_helper'
require 'nagual/mapping/product_variations'

RSpec.describe Nagual::Mapping::ProductVariations do
  subject { described_class.new(row) }

  context 'with mapped values' do
    let(:row) { { 'color': 'Blue,Red' } }

    it 'has no errors' do
      expect(subject.transform)
        .to eq([{ id: 'color', values: %w(Blue Red) }])
    end
  end

  context 'with empty values' do
    let(:row) { { 'color': '' } }

    it 'has no errors' do
      expect(subject.transform).to eq([])
    end
  end

  context 'with not mapped values' do
    let(:row) { { 'other': 'value' } }

    it 'has no errors' do
      expect(subject.transform).to eq([])
    end
  end
end
