require 'spec_helper'
require 'csv_reader'

RSpec.describe CSVReader do

  include_context 'data'

  let(:file) { CSVReader.new.read }

  describe 'read' do

    it 'returns expected result' do
      expect(subject.read).to eq(parsed_content)
    end

  end

end
