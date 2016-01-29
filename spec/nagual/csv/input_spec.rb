require 'spec_helper'
require 'nagual/csv/input'

RSpec.describe Nagual::CSV::Input do
  context 'with correct data' do
    before do
      allow(File)
        .to receive(:read) { %(product_id,ean\n1234, EAN1\n2345, EAN2) }
    end

    it 'returns array of products' do
      expect(subject.products.count).to eq(2)
      expect(subject.products.first.class).to eq(Nagual::Product)
    end
  end
end
