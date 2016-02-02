require 'spec_helper'
require 'nagual/product'
require 'nagual/product_variation'
require 'nagual/xml/product'

RSpec.describe Nagual::XML::Product do
  subject { described_class.new(product) }

  context 'standard product' do
    let(:attributes) { { product_id: 'id', ean: 'EAN', upc: '' } }
    let(:product)    { Nagual::Product.new(attributes: attributes) }

    it 'represents output correctly' do
      expected_xml = "<product product-id=\"id\">\n" \
        "  <ean>EAN</ean>\n" \
        "  <upc/>\n" \
        "  <images/>\n" \
        "  <page-attributes/>\n"

      expect(subject.output).to include(expected_xml)
    end
  end

  context 'product with single variation' do
    let(:variation_values) { ['Blue graphite'] }
    let(:variation) do
      Nagual::ProductVariation.new(id: 'color', values: variation_values)
    end
    let(:product) do
      Nagual::Product.new(attributes: { product_id: 'id' },
                          variations: [variation])
    end

    it 'has variation attributes and variants' do
      expected_xml =
        "  <variations>\n" \
        "    <attributes>\n" \
        '      <variation-attribute attribute-id="color" ' \
        "variation-attribute-id=\"color\">\n" \
        "        <variation-attribute-values>\n" \
        "          <variation-attribute-value value=\"blue-graphite\">\n" \
        '            <display-value xml:lang="x-default">'\
        "Blue graphite</display-value>\n" \
        "          </variation-attribute-value>\n" \
        "        </variation-attribute-values>\n" \
        "      </variation-attribute>\n" \
        "    </attributes>\n" \
        "    <variants>\n" \
        "      <variant product-id=\"id_1\"/>\n" \
        "    </variants>\n" \
        "  </variations>\n" \

      expect(subject.output).to include(expected_xml)
    end
  end

  context 'product with multiple variations' do
    let(:color_variation_values) { %w(Blue Red) }
    let(:size_variation_values)  { %w(Small Large) }
    let(:size_variation) do
      Nagual::ProductVariation.new(id: 'size', values: size_variation_values)
    end
    let(:color_variation) do
      Nagual::ProductVariation.new(id: 'color', values: color_variation_values)
    end
    let(:product) do
      Nagual::Product.new(attributes: { product_id: 'id' },
                          variations: [color_variation, size_variation])
    end

    it 'has variation attributes and variants' do
      expected_xml =
        "  <variations>\n" \
        "    <attributes>\n" \
        '      <variation-attribute attribute-id="color" ' \
        "variation-attribute-id=\"color\">\n" \
        "        <variation-attribute-values>\n" \
        "          <variation-attribute-value value=\"blue\">\n" \
        '            <display-value xml:lang="x-default">'\
        "Blue</display-value>\n" \
        "          </variation-attribute-value>\n" \
        "          <variation-attribute-value value=\"red\">\n" \
        '            <display-value xml:lang="x-default">'\
        "Red</display-value>\n" \
        "          </variation-attribute-value>\n" \
        "        </variation-attribute-values>\n" \
        "      </variation-attribute>\n" \
        '      <variation-attribute attribute-id="size" ' \
        "variation-attribute-id=\"size\">\n" \
        "        <variation-attribute-values>\n" \
        "          <variation-attribute-value value=\"small\">\n" \
        '            <display-value xml:lang="x-default">'\
        "Small</display-value>\n" \
        "          </variation-attribute-value>\n" \
        "          <variation-attribute-value value=\"large\">\n" \
        '            <display-value xml:lang="x-default">'\
        "Large</display-value>\n" \
        "          </variation-attribute-value>\n" \
        "        </variation-attribute-values>\n" \
        "      </variation-attribute>\n" \
        "    </attributes>\n" \
        "    <variants>\n" \
        "      <variant product-id=\"id_1\"/>\n" \
        "      <variant product-id=\"id_2\"/>\n" \
        "      <variant product-id=\"id_3\"/>\n" \
        "      <variant product-id=\"id_4\"/>\n" \
        "    </variants>\n" \
        "  </variations>\n" \

      expect(subject.output).to include(expected_xml)
    end
  end

  context 'product with images' do
    let(:product) do
      Nagual::Product.new(attributes: { product_id: 'id' },
                          images: %w(small medium))
    end

    it 'has image settings with correct view type' do
      expected_xml =
        "  <images>\n" \
        "    <image-group view-type=\"small\">\n" \
        "      <image path=\"images/id_small.png\"/>\n" \
        "    </image-group>\n" \
        "    <image-group view-type=\"medium\">\n" \
        "      <image path=\"images/id_medium.png\"/>\n" \
        "    </image-group>\n" \
        "  </images>\n"

      expect(subject.output).to include(expected_xml)
    end
  end
end
