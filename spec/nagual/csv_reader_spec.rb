require 'spec_helper'

RSpec.describe Nagual::CSVReader do

  include_context 'data'

  subject { described_class.new(Nagual::Configuration.properties["test_csv_file"]) }

  describe 'read' do

    it 'returns expected result' do
      expect(subject.read).to eq(parsed_content)
    end

  end

end
