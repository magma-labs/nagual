require 'spec_helper'
require 'csv_reader'

RSpec.describe CSVReader do

  let(:file) { CSVReader.new.read }
  let(:expected_result) do
    [
      { nombre_autor: 'Rigo Tovar', cancion:  'El Testamento' },
      { nombre_autor: 'Chico Che',  cancion:  'Quen Pompo' }
    ]
  end

  describe 'read' do

    it 'returns expected result' do
      expect(subject.read).to eq(expected_result)
    end

  end

end
