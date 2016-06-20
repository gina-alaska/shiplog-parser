module Shiplogs
  module OldWeather
    class Weather
      include DataFields
      attr_accessor :attributes

      def initialize(data)
        @attributes = data
      end

      def to_json(*args)
        @attributes.to_json(*args)
      end
    end
  end
end
