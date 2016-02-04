require 'spec_helper'
require 'nagual/product'

RSpec.describe Nagual::Product do
  let(:valid_product) { Nagual::Product.new(attributes: { product_id: 'id' }) }
  let(:empty_product) { Nagual::Product.new(attributes: {}) }
  let(:invalid_attrs) { { product_id: 'id', available_flag: 'NOT' } }
  let(:bad_product) do
    Nagual::Product.new(attributes: invalid_attrs)
  end

  it 'creates expected attributes' do
    expect(valid_product.product_id).to eq('id')
    expect(valid_product.valid?).to eq(true)
  end

  it 'validates required values' do
    expect(empty_product.valid?).to eq(false)
    expect(empty_product.errors.first).to include('product_id is invalid')
  end

  it 'validates expected values' do
    expect(bad_product.valid?).to eq(false)
    expect(bad_product.errors.first).to include('available_flag is invalid')
  end
end
