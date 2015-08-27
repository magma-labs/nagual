RSpec.shared_context 'data' do

  let(:parsed_content) do
    [
      { nombre_autor: 'Rigo Tovar', cancion:  'El Testamento' },
      { nombre_autor: 'Chico Che',  cancion:  'Quen Pompo' }
    ]
  end

  let(:raw_xml) do
  """<?xml version=\"1.0\"?>
<catalog>
  <product>
    <nombre_autor>Rigo Tovar</nombre_autor>
    <cancion>El Testamento</cancion>
  </product>
  <product>
    <nombre_autor>Chico Che</nombre_autor>
    <cancion>Quen Pompo</cancion>
  </product>
</catalog>
"""
  end

end
