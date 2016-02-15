require 'spec_helper'
require 'nagual/input/csv'

RSpec.describe Nagual::Input::CSV do
  subject { described_class.new('') }

  context 'with correct data' do
    before do
      allow(File)
        .to receive(:read) do
        "product_id,ean\n" \
        "1234,EAN1\n" \
        "2345,EAN2\n"
      end
    end

    it 'returns array of valid products' do
      expect(subject.rows).to eq([
                                   { 'product_id' => '1234', 'ean' => 'EAN1' },
                                   { 'product_id' => '2345', 'ean' => 'EAN2' }
                                 ])
    end
  end
end
