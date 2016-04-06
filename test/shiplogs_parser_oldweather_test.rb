# encoding: utf-8
require 'test_helper'

class ShiplogsParserOldWeatherTest < MiniTest::Test
  def setup
    @filename = File.expand_path('../fixtures/Bear.json', __FILE__)
    @log = Shiplogs::Parser::OldWeather.new(@filename)
  end

  def test_should_get_page
    assert_kind_of Shiplogs::Parser::Page, @log.pages.first
  end
end
