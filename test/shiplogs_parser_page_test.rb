# encoding: utf-8
require 'test_helper'

class ShiplogsParserPageTest < MiniTest::Unit::TestCase
  def setup
    @unknown_page = Shiplogs::Parser::Page.new('Garbage title')
    @log_page = Shiplogs::Parser::Page.new('17 March 1887')
    @officers_page = Shiplogs::Parser::Page.new('List of Officers')
  end
  
  
  def test_should_return_unknown_page_type
    assert_equal :unknown, @unknown_page.type
  end
  
  def test_should_return_officers_page_type
    assert_equal :officers, @officers_page.type
  end
  
  def test_should_be_log_page_type
    assert_equal :log_page, @log_page.type
  end
end