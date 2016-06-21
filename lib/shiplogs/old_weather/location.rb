module Shiplogs
  module OldWeather
    class Location
      include DataFields
      attr_accessor :attributes

      def initialize(data)
        @attributes = data
      end

      def to_json(*args)
        { name: name, lat: lat, lng: lng }.to_json(*args)
      end

      def name
        [type, (port || portname)].join(': ')
      end



      def lat
        parse_fields(%w(lat_d portlat), @attributes).to_f
      end

      def lng
        parse_fields(%w(lng_d portlon), @attributes).to_f
      end
    end
  end
end
