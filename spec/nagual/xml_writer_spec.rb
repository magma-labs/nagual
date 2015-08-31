require 'spec_helper'

RSpec.describe Nagual::XMLWriter do

  describe 'write' do

    context 'with correct data' do

      include_context 'data'

      subject { described_class.new(parsed_content) }

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
<catalog>
  <product id=\"xd\" mode=\"w\">
    <other>element</other>
  </product>
</catalog>
XML
      end

      subject { described_class.new(parsed_content) }

      it 'generates correct structure' do
        expect(subject.write).to eq(xml_content)
      end

    end

  end

end
