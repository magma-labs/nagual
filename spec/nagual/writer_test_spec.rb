require 'spec_helper'

RSpec.describe Nagual::Writer do

  it 'writes' do
    expect{subject.write}.to raise_error(NotImplementedError)
  end

end
