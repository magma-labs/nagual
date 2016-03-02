require 'spec_helper'
require 'nagual/conversion/product_decoration'

RSpec.describe Nagual::Conversion::ProductDecoration do
  let(:config) do
    {
      'fixed' => { 'available_flag' => 'true' },
      'copy'  => [{ 'key' => 'short_description', 'to' => 'page_description' }],
      'merge' => [{
        'to'   => 'page_url',
        'keys' => %w(product_id organization),
        'pattern' => 'http://host/%{organization}/%{product_id}'
      }],
      'images' => [{
        'view_type'    => 'hi-res',
        'filter_key'   => 'productType',
        'filter_value' => 'regular',
        'names'        => %w(standard shot1 shot2)
      }, {
        'view_type'    => 'hi-res',
        'filter_key'   => 'productType',
        'filter_value' => 'dyo',
        'names'        => %w(standard)
      }],
      'variations' => %w(color)
    }
  end

  let(:fixed_values) { { 'available_flag' => 'true' } }
  let(:base)         { fixed_values.merge(row) }

  subject { described_class.new(row, config) }

  context 'for fixed values' do
    let(:row) { {} }

    it 'adds as expected' do
      expect(subject.build).to eq(base)
    end
  end

  context 'for copy values' do
    let(:row) { { 'short_description' => 'nice description' } }

    it 'adds as expected' do
      expect(subject.build).to eq(base.merge(
                                    'page_description' => 'nice description'))
    end
  end

  context 'for merge values' do
    let(:row) { { 'product_id' => 'id', 'organization' => 'sawyer' } }

    it 'adds as expected' do
      expect(subject.build).to eq(base.merge(
                                    'page_url' => 'http://host/sawyer/id'))
    end
  end

  context 'for images values' do
    context 'with filter values not matching' do
      let(:row) { { 'some' => 'value' } }

      it 'images is empty' do
        expect(subject.build).to eq(base)
      end
    end

    context 'with filter values matching first' do
      let(:row) { { 'productType' => 'regular' } }

      it 'adds as expected' do
        expect(subject.build).to eq(base.merge(
                                      'images' => {
                                        'hi-res' => %w(standard shot1 shot2) }))
      end
    end

    context 'with filter values matching second' do
      let(:row) { { 'productType' => 'dyo' } }

      it 'adds as expected' do
        expect(subject.build).to eq(base.merge(
                                      'images' => {
                                        'hi-res' => %w(standard) }))
      end
    end

    context 'for variation values' do
      context 'with mapped values' do
        let(:row) { { 'color' => 'Blue,Red' } }
        let(:variations) do
          { 'variations' => [{ id: 'color', values: %w(Blue Red) }] }
        end

        it 'has no errors' do
          expect(subject.build).to eq(fixed_values.merge(variations))
        end
      end
    end
  end
end
