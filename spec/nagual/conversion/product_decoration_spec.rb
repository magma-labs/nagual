require 'spec_helper'
require 'nagual/conversion/product_decoration'

RSpec.describe Nagual::Conversion::ProductDecoration do
  subject { described_class.new(row) }

  let(:fixed_values) do
    { 'min_order_quantity' => 10, 'available_flag' => 'true' }
  end
  let(:expected) { fixed_values.merge(row) }

  context 'for fixed values' do
    let(:row) { {} }

    it 'adds as expected' do
      expect(subject.build).to eq(expected)
    end
  end

  context 'for copy values' do
    let(:row) { { 'short_description' => 'nice description' } }

    it 'adds as expected' do
      expect(subject.build).to eq(expected.merge(
                                    'page_description' => 'nice description'))
    end
  end

  context 'for merge values' do
    let(:row) { { 'product_id' => 'id', 'organization' => 'sawyer' } }

    it 'adds as expected' do
      expect(subject.build).to eq(expected.merge(
                                    'page_url' => 'http://host/sawyer/id'))
    end
  end
end
