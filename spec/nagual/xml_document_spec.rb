require 'spec_helper'

RSpec.describe Nagual::XMLDocument do
  describe 'add_child' do
    let(:attributes) { { xmls: 'xmls' } }

    subject do
      described_class.create('catalog', attributes)
        .add_child('product', parsed_content)
        .to_xml
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

  describe 'add_child_in' do

    let(:parent) do
      [
        {
          attributes: {},
          elements: [
            { 'label': 'value-1' }
          ]
        },
        {
          attributes: {},
          elements: [
            { 'label': 'value-2' }
          ]
        }
      ]
    end

    let(:child) do
      [
        {
          attributes: {},
          elements:   [{ other: 'element' }]
        }
      ]
    end

  let(:xml_content) do
    ''"<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<root>
  <parent>
    <label>value-1</label>
    <child-label>
      <other>element</other>
    </child-label>
  </parent>
  <parent>
    <label>value-2</label>
    <child-label>
      <other>element</other>
    </child-label>
  </parent>
</root>
"''
  end

    subject do
      described_class.create('root')
        .add_child('parent', parent)
        .add_child_in('parent', 'child-label', child)
        .to_xml
    end

    it 'generates correct structure' do
      expect(subject).to eq(xml_content)
    end

  end
end
