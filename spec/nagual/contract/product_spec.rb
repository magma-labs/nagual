require 'spec_helper'
require 'nagual/contract/product'

RSpec.describe Nagual::Contract::Product do
  subject { described_class.new(rows) }

  context 'with valid rows' do
    let(:rows) { [{ product_id: 'id' }] }

    it 'has no errors' do
      expect(subject.valid_rows).to eq(rows)
      expect(subject.errors).to be_empty
    end
  end

  context 'with invalid rows' do
    let(:rows) { [{ product_id: 'id', available_flag: 'NOT' }] }

    it 'has expected errors' do
      expect(subject.valid_rows).to be_empty
      expect(subject.errors.first).to include('available_flag is invalid')
    end
  end

  context 'with missing required rows' do
    let(:rows) { [{}] }

    it 'has expected errors' do
      expect(subject.valid_rows).to be_empty
      expect(subject.errors.first).to include('product_id is invalid')
    end
  end
end
