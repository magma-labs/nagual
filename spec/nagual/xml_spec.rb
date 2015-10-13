require 'spec_helper'

RSpec.describe Nagual::XML do
  describe 'document' do
    let(:attributes) { { xmls: 'xmls' } }

    subject do
      described_class.document(parsed_content, 'catalog', 'product',
                               attributes).to_xml
    end

    context 'with correct data' do
      include_context 'data'

      it 'generates expected xml' do
        expect(subject).to eq(xml_content)
      end
    end

    context 'with attributes' do
      let(:parsed_content) do
        [
          {
            attributes: { id: 'xd', mode: 'w' },
            elements:   [{ other: 'element' }]
          }
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
        expect(subject).to eq(xml_content)
      end
    end

    context 'with embedded elements' do
      let(:parsed_content) do
        [{
          attributes: { id: 'xd', mode: 'w' },
          elements:   [{
            embedded: [
              { attributes: { id: 'id' }, elements: [{ other: 'element' }] }
            ]
          }]
        }]
      end

      let(:xml_content) do
        <<-XML
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<catalog xmls="xmls">
  <product id=\"xd\" mode=\"w\">
    <embedded id="id">
      <other>element</other>
    </embedded>
  </product>
</catalog>
        XML
      end

      it 'generates correct structure' do
        expect(subject).to eq(xml_content)
      end
    end
  end
end
