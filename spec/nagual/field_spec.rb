require 'spec_helper'
require 'nagual/field'

RSpec.describe Nagual::Field do
  RSpec.shared_examples 'valid' do |field|
    it 'is valid and with no errors' do
      expect(field).to be_valid
      expect(field.error).to be_empty
    end
  end

  RSpec.shared_examples 'invalid' do |field|
    it 'is valid and with no errors' do
      expect(field).not_to be_valid
      expect(field.error).not_to be_empty
    end
  end

  context 'length' do
    include_examples 'valid', described_class.new('123456', 'string.6')
    include_examples 'invalid', described_class.new('1234567', 'string.6')
  end

  context 'required' do
    include_examples 'valid', described_class.new('hi', 'required')
    include_examples 'invalid', described_class.new('', 'required')
  end

  context 'boolean' do
    include_examples 'valid', described_class.new('true', 'boolean')
    include_examples 'valid', described_class.new('false', 'boolean')
    include_examples 'invalid', described_class.new('not', 'boolean')
  end

  context 'decimal' do
    include_examples 'valid', described_class.new('1.3', 'decimal')
    include_examples 'valid', described_class.new('12', 'decimal')
    include_examples 'invalid', described_class.new('not', 'decimal')
  end

  context 'int' do
    include_examples 'valid', described_class.new('1', 'int')
    include_examples 'valid', described_class.new('12', 'int')
    include_examples 'invalid', described_class.new('1.2', 'int')
    include_examples 'invalid', described_class.new('not', 'int')
  end

  context 'priority' do
    include_examples 'valid',   described_class.new('0.3', 'priority')
    include_examples 'invalid', described_class.new('1.5', 'priority')
    include_examples 'invalid', described_class.new('not', 'priority')
  end

  context 'string' do
    include_examples 'valid', described_class.new('hello', 'string')
    include_examples 'valid', described_class.new('1.2', 'string')
    include_examples 'valid', described_class.new('1.2', 'string')
  end

  context 'frequency' do
    include_examples 'valid', described_class.new('always', 'frequency')
    include_examples 'valid', described_class.new('weekly', 'frequency')
    include_examples 'valid', described_class.new('daily', 'frequency')
    include_examples 'valid', described_class.new('never', 'frequency')
    include_examples 'invalid', described_class.new('not', 'frequency')
  end

  context 'datetime' do
    include_examples 'valid',   described_class.new('2016-11-12', 'datetime')
    include_examples 'invalid', described_class.new('2016-24-12', 'datetime')
    include_examples 'invalid', described_class.new('2016/24/12', 'datetime')
    include_examples 'invalid', described_class.new('not', 'priority')
  end

  context 'unknown' do
    include_examples 'valid', described_class.new('hello', 'unknown')
  end
end
