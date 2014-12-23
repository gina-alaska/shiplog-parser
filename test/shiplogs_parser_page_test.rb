# encoding: utf-8
require 'test_helper'

class ShiplogsParserPageTest < MiniTest::Unit::TestCase
  def setup
    @unknown_page = Shiplogs::Parser::Page.new('Garbage title')
    @log_page = Shiplogs::Parser::Page.new('17 March 1887')
    @officers_page = Shiplogs::Parser::Page.new('List of Officers')
    @manifest_page = Shiplogs::Parser::Page.new('List of Stores on board Jeannette. Engineer\'s stores Col 9-12')
  end
  
  
  def test_should_return_unknown_page_type
    assert_equal :unknown, @unknown_page.type
  end
  
  def test_should_return_officers_page_type
    assert_equal :crew, @officers_page.type
  end

  def test_should_return_officers_page_type
    assert_equal :manifest, @manifest_page.type
  end
  
  def test_should_be_log_page_type
    ['12 March 1887', '4 December 1879'].each do |date|
      assert_equal :log_page, Shiplogs::Parser::Page.new(date).type, "#{date} did not eval as a log_page type"
    end
  end
end