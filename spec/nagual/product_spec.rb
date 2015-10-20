require 'spec_helper'

RSpec.describe Nagual::Product do
  describe 'new' do
    let(:attributes) { { 'product_id' => 'ID' } }
    subject { described_class.new(attributes) }

    it 'creates expected attributes' do
      expect(subject.product_id).to eq('ID')
    end

    it 'represents output correctly' do
      expected_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
      "<product product_id=\"ID\" mode=\"\">\n" +
      "  <product_id>ID</product_id>\n" +
      "  <mode/>\n" +
      "  <ean/>\n" +
      "  <upc/>\n" +
      "  <min_order_quantity/>\n" +
      "  <step_quantity/>\n" +
      "  <display_name/>\n" +
      "  <short_description/>\n" +
      "  <long_description/>\n" +
      "  <online_flag/>\n" +
      "  <online_from/>\n" +
      "  <online_to/>\n" +
      "  <searchable_flag/>\n" +
      "  <searchable_if_unavailable_flag/>\n" +
      "  <images>\n" +
      "    <image-group view_type=\"default\">\n" +
      "      <image path=\"default/ID\"/>\n" +
      "    </image-group>\n" +
      "  </images>\n" +
      "  <images image_group=\"hi\"/>\n" +
      "  <template/>\n" +
      "  <tax_class_id/>\n" +
      "  <brand/>\n" +
      "  <manufacturer_name/>\n" +
      "  <manufacturer_sku/>\n" +
      "  <search_replacement/>\n" +
      "  <search_rank/>\n" +
      "  <sitemap_included_flag/>\n" +
      "  <sitemap_changefrequency/>\n" +
      "  <sitemap_priority/>\n" +
      "</product>\n"
      expect(subject.output.to_xml).to eq(expected_xml)
    end
  end
end
