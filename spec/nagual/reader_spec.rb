require 'spec_helper'

RSpec.describe Nagual::Reader do

  it 'cannot read used directly' do
    expect{subject.read}.to raise_error(NotImplementedError)
  end

end
