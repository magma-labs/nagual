require 'spec_helper'
require 'nagual/conversion/product_division'

RSpec.describe Nagual::Conversion::ProductDivision do
  context 'with none strategy for division' do
    let(:row) { { 'product_id' => 'id' } }

    subject { described_class.new(row, 'none', {}) }

    it 'returns same input' do
      expect(subject.split).to eq([row])
    end
  end

  context 'with variation strategy for division' do
    let(:row) do
      {
        'product_id'       => 'anything',
        'sizes'            => 'S,M,L',
        'manufacturer_sku' => '0015311C'
      }
    end
    let(:params) do
      {
        'variations' => 'sizes',
        'variation'  => 'size',
        'pattern'    => '%{manufacturer_sku}_%{size}'
      }
    end
    let(:result) do
      [{
        'manufacturer_sku' => '0015311C',
        'product_id'       => '0015311C_S',
        'size'             => 'S'
      }, {
        'manufacturer_sku' => '0015311C',
        'product_id'       => '0015311C_M',
        'size'             => 'M'
      }, {
        'manufacturer_sku' => '0015311C',
        'product_id'       => '0015311C_L',
        'size'             => 'L'
      }]
    end
    subject { described_class.new(row, 'variation', params) }

    it 'returns a product for each variation' do
      expect(subject.split).to eq(result)
    end
  end
end
