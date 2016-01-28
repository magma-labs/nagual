require 'spec_helper'
require 'nagual/product'
require 'nagual/xml/product'

RSpec.describe Nagual::XML::Product do
  let(:product) { Nagual::Product.new(product_id: 'id') }

  subject { described_class.new(product) }

  it 'represents output correctly' do
    expected_xml = "<product product-id=\"id\">\n" \
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
      "  <page-attributes>\n" \
      "    <page-title/>\n" \
      "    <page-description/>\n" \
      "    <page-keywords/>\n" \
      "    <page-url/>\n" \
      "  </page-attributes>\n" \
      "  <images>\n" \
      "    <image-group view-type=\"default\">\n" \
      "      <image path=\"default/id\"/>\n" \
      "    </image-group>\n" \
      "  </images>\n" \
      '</product>'

    expect(subject.output).to eq(expected_xml)
  end
end
