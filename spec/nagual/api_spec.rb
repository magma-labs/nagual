require 'spec_helper'
require 'nokogiri'
require 'nagual/api'

RSpec.describe Nagual::API do
  let(:xsd_path)   { 'schema/catalog.xsd' }
  let(:xsd)        { Nokogiri::XML::Schema(File.read(xsd_path)) }

  context 'export' do
    let(:output) { Nokogiri::XML.parse(subject.transform(:csv, :xml_catalog)) }

    it 'conforms to catalog xsd' do
      expect(xsd.validate(output)).to be_empty
    end
  end

  context 'review' do
    let(:output) { subject.transform(:csv, :error_report) }

    it 'returns report' do
      expect(output).to eq(
        "Correct objects read from file: 1\n" \
        "Errors found: 1\n" \
        "Errors:\n" \
        'row #2 | errors: ["searchable_flag is invalid.' \
        " boolean expects values: true or false\"]\n")
    end
  end
end
