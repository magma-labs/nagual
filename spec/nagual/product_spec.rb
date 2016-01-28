require 'spec_helper'
require 'nagual/product'

RSpec.describe Nagual::Product do
  subject { Nagual::Product.new(product_id: 'id') }

  it 'creates expected attributes' do
    expect(subject.product_id).to eq('id')
  end
end
