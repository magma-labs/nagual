require 'spec_helper'
require 'nokogiri'
require 'nagual'

RSpec.describe Nagual do
  let(:xsd_path)   { 'schema/catalog.xsd' }
  let(:xsd)        { Nokogiri::XML::Schema(File.read(xsd_path)) }
  let(:input_path) { 'data_examples/products.csv' }

  subject do
    Nokogiri::XML.parse(Nagual.catalog(input_path))
  end

  it 'conforms to catalog xsd' do
    expect(xsd.validate(subject)).to be_empty
  end
end
