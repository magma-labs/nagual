require 'spec_helper'
require 'nagual/csv/input'

RSpec.describe Nagual::CSV::Input do
  let(:first_product) { subject.products.first }

  context 'with correct data' do
    before do
      allow(File)
        .to receive(:read) do
        "product_id,ean\n" \
        "1234, EAN1\n" \
        "2345, EAN2\n"
      end
    end

    it 'returns array of products' do
      expect(subject.products.count).to eq(2)
      expect(first_product.class).to eq(Nagual::Product)
      expect(first_product.variations).to eq([])
    end
  end

  context 'with variations' do
    before do
      allow(File)
        .to receive(:read) do
        "product_id,ean,variation-color,variation-size\n" \
          "1234, EAN1,\"Blue,Red\",\"Small,Large\"\n" \
      end
    end

    it 'creates product variations correctly' do
      variations = first_product.variations

      expect(variations.size).to eq(2)
      expect(variations.first.class).to eq(Nagual::ProductVariation)
    end
  end
end
