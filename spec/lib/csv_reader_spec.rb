require 'spec_helper'
require 'csv_reader'

RSpec.describe CSVReader do

  include_context 'data'

  subject { described_class.new(Configuration.properties["csv_file"]) }

  describe 'read' do

    it 'returns expected result' do
      expect(subject.read).to eq(parsed_content)
    end

  end

end
