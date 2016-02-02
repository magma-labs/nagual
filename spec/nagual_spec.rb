require 'spec_helper'
require 'nokogiri'
require 'nagual'

RSpec.describe Nagual do
  let(:xsd_path) { Nagual::Configuration.properties['catalog_xsd'] }
  let(:xsd)      { Nokogiri::XML::Schema(File.read(xsd_path)) }
  let(:input)    { Nagual::CSV::Input.new(file: 'data_examples/products.csv') }

  subject do
    Nokogiri::XML.parse(Nagual.catalog(input: input))
  end

  it 'conforms to catalog xsd' do
    xsd.validate(subject).each do |error|
      puts error.message
    end
    expect(xsd.valid?(subject)).to be true
  end
end
