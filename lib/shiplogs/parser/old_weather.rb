module Shiplogs
  module Parser
    class OldWeather
      def initialize(file)
        filename = file
        @pages = []
      end

      def json_content
        @json_content ||= JSON.parse(File.read(filename))
      end

      def pages
        return @pages unless @pages.nil?

        json_content['pages'].each do |page|
          puts page.inspect
          exit
        end

        @pages
      end
    end
  end
end
