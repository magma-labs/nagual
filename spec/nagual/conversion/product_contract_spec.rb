require 'spec_helper'
require 'nagual/conversion/product_contract'

RSpec.describe Nagual::Conversion::ProductContract do
  subject { described_class.new(row) }

  context 'with valid row' do
    let(:row) { { 'product_id' => 'id' } }

    it 'has no errors' do
      expect(subject).to be_valid
      expect(subject.errors).to be_empty
    end
  end

  context 'with invalid row' do
    let(:row) { { 'product_id' => 'id', 'available_flag' => 'NOT' } }

    it 'has expected errors' do
      expect(subject).not_to be_valid
      expect(subject.errors.first).to include('available_flag is invalid')
    end
  end

  context 'with missing required row' do
    let(:row) { {} }

    it 'has expected errors' do
      expect(subject).not_to be_valid
      expect(subject.errors.first).to include('product_id is invalid')
    end
  end
end
