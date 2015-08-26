require 'spec_helper'
require 'writer'

RSpec.describe Writer do

  it 'writes' do
    expect{subject.write}.to raise_error(NotImplementedError)
  end

end
