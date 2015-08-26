require 'spec_helper'
require 'csv_reader'

RSpec.describe CSVReader do

  let(:file) { CSVReader.new.read }

  it 'reads file into an array' do
    expect(file.class).to eq(Array)
  end

  it 'contains expected content' do
    expect(file[0][0]).to eq('Rigo Tovar')
  end

end
