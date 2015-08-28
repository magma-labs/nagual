require 'spec_helper'

RSpec.describe Nagual::CSVReader do

  include_context 'data'

  describe 'read' do

    context 'with correct data' do

      let(:csv_text) do
        %Q{Nombre Autor,Cancion
          Rigo Tovar, El Testamento
          Chico Che, Quen Pompo}
      end

      subject { described_class.new(csv_text) }

      it 'returns parsed content' do
        expect(subject.read).to eq(parsed_content)
      end

    end

  end

end
