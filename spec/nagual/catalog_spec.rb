require 'spec_helper'

RSpec.describe Nagual::Catalog do
  let(:xsd_path) { Nagual::Configuration.properties['catalog_xsd'] }
  let(:xsd)      { Nokogiri::XML::Schema(File.read(xsd_path)) }
  let(:input) do
    File.read(Nagual::Configuration.properties['input_test_file'])
  end

  subject do
    Nokogiri::XML.parse(described_class.new(input).to_xml)
  end

  it 'conforms to catalog xsd' do
    xsd.validate(subject).each do |error|
      puts error.message
    end
    expect(xsd.valid?(subject)).to be true
  end
end
