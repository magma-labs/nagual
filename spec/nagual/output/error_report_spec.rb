require 'spec_helper'
require 'nagual/output/error_report'

RSpec.describe Nagual::Output::ErrorReport do
  it 'represents output correctly' do
    expected = "Correct objects read from file: 0\n" \
     "Errors found: 0\n" \
     "Errors:\n" \

    expect(subject.write([], [])).to eq(expected)
  end
end
