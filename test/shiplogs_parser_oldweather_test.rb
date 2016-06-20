# encoding: utf-8
require 'test_helper'
require 'pp'

class ShiplogsParserOldWeatherTest < MiniTest::Test
  def setup
    @filename = File.expand_path('../fixtures/Bear.json', __FILE__)
    @log = Shiplogs::Parser::OldWeather.new(@filename)
  end

  def test_should_get_weather_page
    page = @log.pages[29]

    assert_equal '50874d7409d4090755002f7b', page.id
    assert_kind_of Shiplogs::OldWeather::Page, page
  end

  def test_should_get_log_page
    page = @log.pages[31]
    # page = raw_page.as_parser_page

    a = @log.pages.collect do |p|
      next unless p.as_parser_page.type == :log_page

      { id: p.id, date: p.title, content: p.transcriptions.events } unless p.transcriptions.events.empty?
    end.compact

    File.open('testing.json', 'w') do |fp|
      fp << JSON.pretty_generate({ pages: a })
    end

    # assert_equal "11/05/1897", page.title
    assert_equal "", page.transcriptions.events
  end
end
