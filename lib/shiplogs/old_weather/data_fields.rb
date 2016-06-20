module Shiplogs
  module OldWeather
    module DataFields
      def id(hint = nil, source = nil)
        source = attributes if source.nil?

        if source.include?('$oid')
          value = source['$oid']
        else
          value = id(nil, source["#{hint}_id"])
        end

        value
      end

      def parse_fields(fields, source)
        value = nil
        fields.each do |field|
          next unless source.include?(field)
          next if source[field].nil? || source[field].empty?

          value ||= source[field]
        end

        value
      end

      def latitude(source)
        lat = parse_fields(%w(latitude portlat), source)
        lat.to_f unless lat.nil?
      end

      def longitude(source)
        lat = parse_fields(%w(longitude portlon), source)
        lat.to_f unless lat.nil?
      end

      def method_missing(method, value = nil)
        if attributes.include?(method.to_s)
          attributes[method.to_s]
        end
      end
    end
  end
end
