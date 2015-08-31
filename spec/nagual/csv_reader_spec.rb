require 'spec_helper'

RSpec.describe Nagual::CSV do

  describe 'to_hash' do

    subject { described_class.new(csv_text) }

    context 'with correct data' do

      include_context 'data'

      let(:csv_text) do
        %Q{Nombre Autor,Cancion
          Rigo Tovar, El Testamento
          Chico Che, Quen Pompo}
      end

      it 'returns parsed content' do
        expect(subject.to_hash).to eq(parsed_content)
      end

    end

    context 'with empty values' do

      let(:csv_text) do
        %Q{Name,Address,Phone
           Oscar,,333358390}
      end

      let(:parsed_content) do
        [{:name=>"Oscar", :address=>"", :phone=>"333358390"}]
      end

      it 'parses to empty string' do
        expect(subject.to_hash).to eq(parsed_content)
      end

    end

  end

end
