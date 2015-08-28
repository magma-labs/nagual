require 'spec_helper'

RSpec.describe Nagual::Writer do

  it 'cannot read used directly' do
    expect{subject.write}.to raise_error(NotImplementedError)
  end

end
