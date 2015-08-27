require 'spec_helper'

RSpec.describe Nagual::XMLWriter do

  include_context 'data'

  subject { described_class.new(parsed_content) }

  it 'writes' do
    expect(subject.write).to eq(raw_xml)
  end

end
