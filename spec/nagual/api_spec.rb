require 'spec_helper'
require 'nokogiri'
require 'nagual/api'

RSpec.describe Nagual::API do
  context 'transform to xml catalog' do
    let(:xsd_path)   { 'schema/catalog.xsd' }
    let(:xsd)        { Nokogiri::XML::Schema(File.read(xsd_path)) }
    let(:output)     { 'data_examples/catalog.xml' }

    subject! do
      described_class.new.transform(:catalog, :csv, :xml_catalog)
    end

    it 'conforms to catalog xsd' do
      expect(xsd.validate(output)).to be_empty
    end
  end

  context 'transform to error report' do
    let(:output) { File.read('data_examples/error_report') }

    subject! do
      described_class.new.transform(:catalog, :csv, :error_report)
    end

    it 'writes to file' do
      expect(output).to eq(
        "Correct objects read from file: 1\n" \
        "Errors found: 1\n" \
        "Errors:\n" \
        'id: INVALID | errors: ["searchable_flag is invalid.' \
        " boolean expects values: true or false\"]\n"
      )
    end
  end
end
