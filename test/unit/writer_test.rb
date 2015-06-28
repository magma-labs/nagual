require 'test/unit'
require 'writer'

class WriterTest < Test::Unit::TestCase
  def test_write
    assert_raise do #Fails, no Exceptions are raised
      writer.write
    end
  end
end
