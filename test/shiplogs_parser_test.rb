require 'test_helper'

class ShiplogsParserTest < MiniTest::Test
  def test_should_have_version
    assert !Shiplogs::Parser::VERSION.nil?
  end

  def test_should_initialize_html_parser
    parser = Shiplogs::Parser.load(File.expand_path('fixtures/USS_Bear_1884_log.html', __FILE__))

    assert_instance_of Shiplogs::Parser::Html, parser
  end
end
