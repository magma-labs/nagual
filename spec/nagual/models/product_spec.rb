require 'spec_helper'
require 'nagual/models/product'

RSpec.describe Nagual::Models::Product do
  let(:attributes) do
    { 'product_id' => 'id', 'organization' => 'sawyer' }
  end
  let(:valid_product) do
    Nagual::Models::Product.new(attributes: attributes)
  end

  it 'creates expected attributes' do
    expect(valid_product.product_id).to eq('id')
  end

  it 'creates custom attributes' do
    expect(valid_product.custom_attributes).to eq(organization: 'sawyer')
  end
end
