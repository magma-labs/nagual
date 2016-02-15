require 'spec_helper'
require 'nokogiri'
require 'nagual/api'

RSpec.describe Nagual::API do
  let(:xsd_path)   { 'schema/catalog.xsd' }
  let(:xsd)        { Nokogiri::XML::Schema(File.read(xsd_path)) }
  let(:input_path) { 'data_examples/products.csv' }

  context 'export' do
    let(:output) { Nokogiri::XML.parse(subject.export(input_path)) }

    it 'conforms to catalog xsd' do
      expect(xsd.validate(output)).to be_empty
    end
  end

  context 'review' do
    let(:output) { subject.review(input_path) }

    it 'returns report' do
      expect(output).to eq(
        "Rows read from file: 2\n" \
        "Errors found: 1\n" \
        "Errors:\n" \
        'row #2 | errors: ["searchable_flag is invalid.' \
        " boolean expects values: true or false\"]\n")
    end
  end

  context 'config' do
    let(:input) { subject.config['input_file'] }

    it 'returns values as expected' do
      expect(input).to eq('data/products.csv')
    end
  end
end
