require 'spec_helper'

RSpec.describe Nagual::Catalog do
  let(:xsd_path) { Nagual::Configuration.properties['catalog_xsd'] }
  let(:xsd)      { Nokogiri::XML::Schema(File.read(xsd_path)) }
  let(:input) do
    File.read('data_examples/products.csv')
  end

  subject do
    products = Nagual::Input.new(input).products
    Nokogiri::XML.parse(described_class.new(products).output)
  end

  it 'conforms to catalog xsd' do
    xsd.validate(subject).each do |error|
      puts error.message
    end
    expect(xsd.valid?(subject)).to be true
  end
end
