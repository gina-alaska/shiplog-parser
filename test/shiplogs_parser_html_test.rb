# encoding: utf-8
require 'test_helper'

class ShiplogsParserHtmlTest < MiniTest::Unit::TestCase
  def setup
    @url = File.expand_path('../fixtures/USS_Bear_1884_log.html', __FILE__)
    @log = Shiplogs::Parser::Html.new(@url)
  end
  
  def test_responds_to_url
    assert_equal @url, @log.url
  end
  
  def test_should_return_html_document
    assert_instance_of Nokogiri::HTML::Document, @log.document
  end
  
  def test_should_return_log_content
    assert !@log.content.nil?
  end
  
  def test_should_find_pages
    assert_equal 259, @log.pages.count
  end  
  
  def test_should_pull_out_page_title
    assert_equal 'LOG BOOK – MARCH 17TH 1884 TO SEPTEMBER 22ND 1884', @log.pages[0].title
  end
  
  def test_should_pull_out_page_content
    assert @log.pages[0].content.length > 0, "Page content was empty"
  end
  
  def test_fourth_page_should_be_log_page
    assert_equal :log_page, @log.pages[3].type
  end
end