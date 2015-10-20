require 'spec_helper'

RSpec.describe Nagual::Product do
  describe 'new' do
    let(:attributes) { { 'product_id' => 'ID' } }
    subject { described_class.new(attributes) }

    it 'creates expected attributes' do
      expect(subject.product_id).to eq('ID')
    end

    it 'ignores other attributes' do
    end
  end
end
