require 'shiplogs/parser'
require 'pp'

filename = 'test/fixtures/Bear.json'
log =  Shiplogs::Parser::OldWeather.new(filename)



puts log.simplify.to_json
# puts log.pages.collect(&:weather).inspect
# puts log.pages.collect(&:CPosition).flatten.compact
# pp log.pages[120].transcriptions.annotations.attributes
