require 'spec_helper'

RSpec.describe Nagual::CSV do
  describe 'to_a' do
    subject { described_class.new(csv_text) }

    context 'with correct data' do
      include_context 'data'

      let(:csv_text) do
        %(Nombre Autor,Cancion
          Rigo Tovar, El Testamento
          Chico Che, Quen Pompo)
      end

      it 'returns parsed content' do
        expect(subject.to_a).to eq(parsed_content)
      end
    end

    context 'with empty values' do
      let(:csv_text) do
        %(Name,Address,Phone
           Oscar,,333358390)
      end

      let(:parsed_content) do
        [{
          attributes: { name: 'Oscar' },
          elements: [{ phone: '333358390' }]
        }]
      end

      it 'parses to empty string' do
        expect(subject.to_a([:name])).to eq(parsed_content)
      end
    end
  end
end
