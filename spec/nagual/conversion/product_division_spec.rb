require 'spec_helper'
require 'nagual/conversion/product_division'

RSpec.describe Nagual::Conversion::ProductDivision do
  let(:row) { { 'product_id' => 'id' } }

  context 'with no strategy for division' do
    subject { described_class.new(row, 'none', {}) }

    it 'returns same input' do
      expect(subject.split).to eq(row)
    end
  end
end
