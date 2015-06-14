require 'test/unit'
require "configuration"

class SettingsTest < Test::Unit::TestCase
  def test_we_can_read_config_file
    assert_not_nil Configuration
  end
end
