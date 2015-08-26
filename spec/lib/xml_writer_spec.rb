require 'spec_helper'
require 'xml_writer'

RSpec.describe XMLWriter do

  it 'writes' do
    expect(subject.write).not_to be_nil
  end

end
