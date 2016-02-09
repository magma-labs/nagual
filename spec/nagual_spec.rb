require 'spec_helper'
require 'nokogiri'
require 'nagual'

RSpec.describe Nagual do
  let(:xsd_path)   { 'schema/catalog.xsd' }
  let(:xsd)        { Nokogiri::XML::Schema(File.read(xsd_path)) }
  let(:input_path) { 'data_examples/products.csv' }

  context 'export' do
    subject { Nokogiri::XML.parse(Nagual.export(input_path)) }

    it 'conforms to catalog xsd' do
      expect(xsd.validate(subject)).to be_empty
    end
  end

  context 'review' do
    subject { Nagual.review(input_path) }

    it 'returns report' do
      expect(subject).to eq(
        "1 valid products\n" \
        "1 invalid products\n" \
        "Errors:\n" \
        'id: INVALID | errors: ["searchable_if_unavailable_flag is invalid.' \
        " boolean expects values: true or false\"]\n")
    end
  end
end
