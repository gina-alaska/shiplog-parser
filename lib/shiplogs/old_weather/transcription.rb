module Shiplogs
  module OldWeather
    class Transcription
      include DataFields

      attr_accessor :attributes

      def initialize(data=[])
        @attributes = data
      end

      def annotations
        @annotations ||= Annotation.new(attributes.map { |item| item['annotations'] }.flatten)
      end

      def geolocations
        annotations.geolocations
      end

      def events
        annotations.events
      end
    end
  end
end
