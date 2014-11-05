require 'open-uri'
require "nokogiri"
require "shiplogs/parser/version"
require "shiplogs/parser/html"
require "shiplogs/parser/page"

module Shiplogs
  module Parser
    # Your code goes here...
    def self.load(url)
      Html.new(url)
    end
  end
end
