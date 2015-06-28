require 'test/unit'
require 'writer'

class WriterTest < Test::Unit::TestCase
  def test_write
    assert_raise NotImplementedError do #Fails, no Exceptions are raised
      Writer.new.write
    end
  end
end
