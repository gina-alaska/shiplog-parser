module Shiplogs
  module OldWeather
    class Page
      include DataFields
      attr_accessor :title, :attributes, :content

      def initialize(data)
        @attributes = data
      end

      def self.from_json(left, right)
        merge_keys = left.keys - right.keys
        merge_keys.each do |field|
          right[field] = left[field]
        end

        right['locations'] = [left['location'], right['location']]
        right['transcriptions'] += left['transcriptions']
        new(right)
      end

      def voyage_id
        id('voyage')
      end

      def title
        if self.CDate
          self.CDate['data']['date']
        end
      end

      def date
        if self.CDate && self.CDate != 'null'
          Date.strptime(self.CDate['data']['date'], '%d/%m/%Y')
        end
      rescue ArgumentError => e
      end

      def weather
        self.CWeather.compact.collect { |obs| Weather.new(obs['data']) } if self.CWeather
      end

      def transcriptions
        @transcriptions ||= Transcription.new(attributes['transcriptions'])
      end

      def images
        locations
      end

      def geolocations
        transcriptions.geolocations
      end

      def type
        Shiplogs::Parser::Page.new(title) || :unknown
      end

      def as_parser_page
        Shiplogs::Parser::Page.new(title, transcriptions.events)
      end
    end
  end
end
