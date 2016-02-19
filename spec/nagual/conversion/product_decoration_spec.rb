require 'spec_helper'
require 'nagual/conversion/product_decoration'

RSpec.describe Nagual::Conversion::ProductDecoration do
  subject { described_class.new(row) }

  context 'for fixed values' do
    let(:row) { {} }

    it 'adds as expected' do
      expect(subject.build).to eq('min_order_quantity' => 10,
                                  'available_flag' => 'true')
    end
  end
end
