module Shiplogs
  module OldWeather
    class Annotation
      include DataFields

      attr_accessor :attributes

      ACCEPTED_EVENT_KEYS = %w{ event undefined portname  }

      def initialize(data=[])
        @attributes = data
      end

      def data
        attributes.map { |item| item['data'] }
      end

      def parse_geolocations
        data.collect do |item|
          loc = { lng: longitude(item), lat: latitude(item) }
          (loc[:lng].nil? || loc[:lat].nil?) ? nil : loc
        end.compact
      end

      def geolocations
        @geolocations ||= parse_geolocations
      end

      def rejected_events
        @rejected_events ||= data.collect do |item|
          item.reject { |k,v| ACCEPTED_EVENT_KEYS.include?(k) }.values
        end.flatten.compact.uniq
      end

      def events
        @events ||= data.collect do |item|
          item.select { |k,v| ACCEPTED_EVENT_KEYS.include?(k) }.values
        end.flatten.compact.uniq
      end
    end
  end
end
