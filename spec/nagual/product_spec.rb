require 'spec_helper'
require 'nagual/product'

RSpec.describe Nagual::Product do
  let(:valid_product) { Nagual::Product.new(attributes: { product_id: 'id' }) }
  let(:empty_product) { Nagual::Product.new(attributes: {}) }
  let(:invalid_attrs) { valid_product.merge(available_flag: 'NOT') }
  let(:bad_product) do
    Nagual::Product.new(attributes: invalid_attrs)
  end

  it 'creates expected attributes' do
    expect(valid_product.product_id).to eq('id')
  end

  it 'validates required values' do
    pending
    expect(empty_product.errors).to eq(['product_id is invalid'])
  end

  it 'validates expected values' do
    pending
    expect(bad_product.errors).to eq(['available_flag is invalid'])
  end
end
