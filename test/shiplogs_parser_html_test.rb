# encoding: utf-8
require 'test_helper'

class ShiplogsParserHtmlTest < MiniTest::Test
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
    assert_equal 227, @log.pages.count
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

  def test_duplicate_page_titles
    url = File.expand_path('../fixtures/USRC_Bear-1890-1891.htm', __FILE__)
    log = Shiplogs::Parser::Html.new(url)
    assert log.pages[4].title != log.pages[5].title, "Found pages with duplicate titles"
  end

  def test_alternate_log_format
    url = File.expand_path("../fixtures/OWShips-WW1-18-HMS_Acacia.htm", __FILE__)
    log = Shiplogs::Parser::Html.new(url)
    assert log.pages.count > 0, "Did not find any pages in alternate log format"
  end

  def test_alternate_log_format_page_type
    url = File.expand_path("../fixtures/OWShips-WW1-18-HMS_Acacia.htm", __FILE__)
    log = Shiplogs::Parser::Html.new(url)
    assert_equal :log_page, log.pages[2].type
  end

  def test_title_content_should_strip_special_characters
    html = Shiplogs::Parser::Html.new('')
    node = OpenStruct.new(content: "14\r May\n 1900\n" )
    assert_equal "14 May 1900", html.send(:title_content, node), "Found special character"
  end
end
