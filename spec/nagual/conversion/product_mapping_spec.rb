require 'spec_helper'
require 'nagual/conversion/product_mapping'

RSpec.describe Nagual::Conversion::ProductMapping do
  let(:mutations) do
    [
      { 'key' => 'id', 'to' => 'product_id', 'name' => 'none' },
      { 'key' => 'status', 'to' => 'online_flag', 'name' => 'convert',
        'params' => {
          'default' => 'false',
          'values'  => { 'online' => 'true' }
        } }
    ]
  end

  subject { described_class.new(row, mutations) }

  context 'with simple mapped values' do
    let(:row) { { 'id' => 'id' } }

    it 'has no errors' do
      expect(subject.transform).to eq('product_id' => 'id')
    end
  end

  context 'with not simple mapped values' do
    let(:row) { { 'non-existent': 'value' } }

    it 'has no errors' do
      expect(subject.transform).to eq({})
    end
  end

  context 'with mutation values' do
    context 'boolean' do
      context 'with expected value' do
        let(:row) { { 'status' => 'online' } }

        it 'returns true' do
          expect(subject.transform).to eq('online_flag' => 'true')
        end
      end

      context 'with other value' do
        let(:row) { { 'status' => 'offline' } }

        it 'returns true' do
          expect(subject.transform).to eq('online_flag' => 'false')
        end
      end
    end
  end
end
