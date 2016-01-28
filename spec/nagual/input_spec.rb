require 'spec_helper'
require 'nagual/input'

RSpec.describe Nagual::Input do
  describe 'to_a' do
    subject { described_class.new(csv_text) }

    context 'with correct data' do
      let(:csv_text) do
        %(product_id,ean\n1234, EAN1\n2345, EAN2)
      end

      it 'returns array of products' do
        expect(subject.products.count).to eq(2)
        expect(subject.products.first.class).to eq(Nagual::Product)
      end
    end
  end
end
