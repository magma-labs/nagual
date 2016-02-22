require 'spec_helper'
require 'nagual/conversion/product_decoration'

RSpec.describe Nagual::Conversion::ProductDecoration do
  let(:config) do
    {
      'fixed' => { 'available_flag' => 'true' },
      'copy'  => [{ 'key' => 'short_description', 'to' => 'page_description' }],
      'merge' => [
        {
          'to'   => 'page_url',
          'keys' => %w(product_id organization),
          'pattern' => 'http://host/%{organization}/%{product_id}'
        }
      ]
    }
  end

  let(:fixed_values) { { 'available_flag' => 'true' } }
  let(:expected)     { fixed_values.merge(row) }

  subject { described_class.new(row, config) }

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
