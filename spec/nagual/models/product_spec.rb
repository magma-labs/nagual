require 'spec_helper'
require 'nagual/models/product'

RSpec.describe Nagual::Models::Product do
  let(:empty_product) { Nagual::Models::Product.new(attributes: {}) }
  let(:invalid_attrs) { { product_id: 'id', available_flag: 'NOT' } }
  let(:valid_product) do
    Nagual::Models::Product.new(attributes: { product_id: 'id' })
  end
  let(:bad_product) do
    Nagual::Models::Product.new(attributes: invalid_attrs)
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
