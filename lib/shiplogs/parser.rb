require 'version'
require 'open-uri'
require "nokogiri"
require 'json'
require "shiplogs/old_weather/data_fields"
require "shiplogs/old_weather/weather"
require "shiplogs/old_weather/location"
require "shiplogs/old_weather/page"
require "shiplogs/old_weather/annotation"
require "shiplogs/old_weather/transcription"
require "shiplogs/parser/html"
require "shiplogs/parser/page"
require "shiplogs/parser/old_weather"

module Shiplogs
  module Parser
    is_versioned
    # Your code goes here...
    def self.load(url)
      Html.new(url)
    end
  end
end
