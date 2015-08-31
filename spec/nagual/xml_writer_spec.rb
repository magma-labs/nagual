require 'spec_helper'

RSpec.describe Nagual::XMLWriter do

  describe 'write' do

    let(:attributes) { {xmls: 'xmls'} }

    subject do
      described_class.new('catalog', 'product', attributes, parsed_content)
    end

    context 'with correct data' do

      include_context 'data'

      it 'generates expected xml' do
        expect(subject.write).to eq(xml_content)
      end

    end

    context 'with attributes' do

      let(:parsed_content) do
        [
          { attributes: {id: "xd", mode: "w"}, other: 'element' }
        ]
      end

      let(:xml_content) do
<<-XML
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<catalog xmls="xmls">
  <product id=\"xd\" mode=\"w\">
    <other>element</other>
  </product>
</catalog>
XML
      end

      it 'generates correct structure' do
        expect(subject.write).to eq(xml_content)
      end

    end

  end

end
