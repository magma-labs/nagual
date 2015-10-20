require 'spec_helper'

RSpec.describe Nagual::Product do
  describe 'new' do
    let(:attributes) { { 'product_id' => 'ID' } }
    subject { described_class.new(attributes) }

    it 'creates expected attributes' do
      expect(subject.product_id).to eq('ID')
    end

    it 'represents output correctly' do
      expected_xml = "<product product-id=\"ID\">\n" \
      "  <ean/>\n" \
      "  <upc/>\n" \
      "  <min-order-quantity/>\n" \
      "  <step-quantity/>\n" \
      "  <display-name/>\n" \
      "  <short-description/>\n" \
      "  <long-description/>\n" \
      "  <online-flag/>\n" \
      "  <online-from/>\n" \
      "  <online-to/>\n" \
      "  <searchable-flag/>\n" \
      "  <searchable-if-unavailable-flag/>\n" \
      "  <images>\n" \
      "    <image-group view-type=\"default\">\n" \
      "      <image path=\"default/ID\"/>\n" \
      "    </image-group>\n" \
      "  </images>\n" \
      "  <template/>\n" \
      "  <tax-class-id/>\n" \
      "  <brand/>\n" \
      "  <manufacturer-name/>\n" \
      "  <manufacturer-sku/>\n" \
      "  <search-placement/>\n" \
      "  <search-rank/>\n" \
      "  <sitemap-included-flag/>\n" \
      "  <sitemap-changefrequency/>\n" \
      "  <sitemap-priority/>\n" \
      "  <page-attributes/>\n" \
      '</product>'
      expect(subject.output.to_xml).to eq(expected_xml)
    end
  end
end
