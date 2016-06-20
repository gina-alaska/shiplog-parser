module Shiplogs
  module Parser
    class OldWeather
      def initialize(file)
        @filename = file
        @pages = []
      end

      def data_field(type, content)
        Shiplogs::OldWeather::DataFields.send(type, content)
      end

      def json_content
        @json_content ||= JSON.parse(File.read(@filename).force_encoding('utf-8'))
      end

      def pages
        return @pages unless @pages.empty?

        @pages = []
        rawpages = {}
        json_content['pages'].each do |node|
          rawpages[node['order'].to_i] = node
        end

        tmp_pages = rawpages.sort
        while tmp_pages.size > 0
          if tmp_pages.first[1]['page'] == 'left'
            left = tmp_pages.shift
            right = tmp_pages.shift
            @pages << Shiplogs::OldWeather::Page.from_json(left[1], right[1])
          else
            tmp_pages.shift
          end
        end

        @pages
      end

      def simplify
        pages.collect do |p|
          {
            id: p.id,
            title: p.title,
            voyage_id: p.voyage_id,
            type: p.as_parser_page.type,
            date: p.date,
            images: p.images,
            geolocations: p.geolocations,
            weather: p.weather,
            content: p.transcriptions.events
          }
        end.compact
      end
    end
  end
end
