RSpec.shared_context 'data' do

  let(:parsed_content) do
    [
      { :"nombre-autor" => 'Rigo Tovar', cancion:  'El Testamento' },
      { :"nombre-autor" => 'Chico Che',  cancion:  'Quen Pompo' }
    ]
  end

  let(:xml_content) do
  """<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<catalog xmls=\"xmls\">
  <product>
    <nombre-autor>Rigo Tovar</nombre-autor>
    <cancion>El Testamento</cancion>
  </product>
  <product>
    <nombre-autor>Chico Che</nombre-autor>
    <cancion>Quen Pompo</cancion>
  </product>
</catalog>
"""
  end

end
