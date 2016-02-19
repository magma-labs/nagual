require 'spec_helper'
require 'nagual/conversion/images_mapping'

RSpec.describe Nagual::Conversion::ImagesMapping do
  subject { described_class.new(row) }

  context 'with mapped values' do
    let(:row) { { 'images' => 'small,large' } }

    it 'has no errors' do
      expect(subject.transform).to eq(%w(small large))
    end
  end

  context 'with empty values' do
    let(:row) { { 'images' => '' } }

    it 'has no errors' do
      expect(subject.transform).to eq([])
    end
  end

  context 'with not mapped values' do
    let(:row) { { 'other' => 'value' } }

    it 'has no errors' do
      expect(subject.transform).to eq([])
    end
  end
end
