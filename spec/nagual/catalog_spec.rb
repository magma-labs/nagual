require 'spec_helper'

RSpec.describe Nagual::Catalog do
  let(:xsd_path) { Nagual::Configuration.properties['catalog_xsd'] }
  let(:xsd)      { Nokogiri::XML::Schema(File.read(xsd_path)) }
  let(:csv) do
    File.read('data_examples/products.csv')
  end

  subject do
    input = Nagual::Input.new(csv)
    Nokogiri::XML.parse(described_class.new(input).output)
  end

  it 'conforms to catalog xsd' do
    xsd.validate(subject).each do |error|
      puts error.message
    end
    expect(xsd.valid?(subject)).to be true
  end
end
