require 'spec_helper'

RSpec.describe Nagual::CSV do
  describe 'to_a' do
    subject { described_class.new(csv_text) }

    context 'with correct data' do
      include_context 'data'

      let(:csv_text) do
        %(Nombre Autor,Cancion
          Rigo Tovar, El Testamento
          Chico Che, Quen Pompo)
      end

      it 'returns parsed content' do
        expect(subject.to_a).to eq(parsed_content)
      end
    end

    context 'with empty values' do
      let(:csv_text) do
        %(Name,Address,Phone
           Oscar,,333358390)
      end

      let(:parsed_content) do
        [{
          attributes: { name: 'Oscar' },
          elements: [{ address: '', phone: '333358390' }]
        }]
      end

      it 'parses to empty string' do
        expect(subject.to_a([:name])).to eq(parsed_content)
      end
    end
  end

  describe '#add_children' do
    context 'with child key' do
      let(:parent) do
        [{
          elements: [{ children: '1,2' }],
          attributes: {}
        },
         {
           elements: [{ children: '3' }],
           attributes: { a: 'a' }
         },
         {
           elements: [{ children: '' }],
           attributes: {}
         }]
      end
      let(:children) do
        [
          { elements: [{ id: '1', value: 'a' }], attributes: {} },
          { elements: [{ id: '2', value: 'b' }], attributes: {} },
          { elements: [{ id: '3', value: 'c' }], attributes: { b: 'b' } }
        ]
      end
      let(:combined) do
        [{
          elements: [{
            children: [{
              elements: [{
                child: [{
                  elements: [{ value: 'a' }, { value: 'b' }],
                  attributes: {}
                }]
              }]
            }]
          }],
          attributes: {}
        },
         {
           elements: [{
             children: [{
               elements: [{
                 child: [{ elements: [{ value: 'c' }], attributes: { b: 'b' } }]
               }]
             }]
           }],
           attributes: { a: 'a' }
         },
         {
           elements: [{ children: '' }],
           attributes: {}
         }]
      end

      subject do
        described_class.add_children(parent, :children, children, :child)
      end

      it 'returns parent with embedded children' do
        expect(subject).to eq(combined)
      end
    end

    context 'without child key' do
      let(:parent) do
        [{
          elements: [{ children: '3' }],
          attributes: {}
        }]
      end
      let(:children) do
        [
          { elements: [{ id: '3', value: 'a' }], attributes: {} }
        ]
      end
      let(:combined) do
        [{
          elements: [{
            children: [{
              elements: [{ value: 'a' }], attributes: {}
            }]
          }],
          attributes: {}
        }]
      end

      subject do
        described_class.add_children(parent, :children, children)
      end

      it 'returns parent with embedded children' do
        expect(subject).to eq(combined)
      end
    end
  end
end
