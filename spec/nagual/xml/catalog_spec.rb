require 'spec_helper'
require 'nagual/catalog'
require 'nagual/xml/catalog'

RSpec.describe Nagual::XML::Catalog do
  let(:catalog) { Nagual::Catalog.new([]) }

  subject { described_class.new(catalog) }

  it 'represents output correctly' do
    expected_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" \
    '<catalog xmlns="http://www.demandware.com/xml/impex/catalog/2006-10-31"' \
    " catalog-id=\"nagual-catalog\">\n" \
    "  <header>\n" \
    "    <image-settings>\n" \
    "      <internal-location base-path=\"/images\"/>\n" \
    "      <view-types>\n" \
    "        <view-type>default</view-type>\n" \
    "      </view-types>\n" \
    "      <alt-pattern>${productname}</alt-pattern>\n" \
    "      <title-pattern>${productname}</title-pattern>\n" \
    "    </image-settings>\n" \
    "  </header>\n" \
    "</catalog>\n"

    expect(subject.output).to eq(expected_xml)
  end
end
