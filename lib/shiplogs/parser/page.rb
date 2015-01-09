module Shiplogs
  module Parser
    class Page
      attr_accessor :title, :content

      def initialize(title, content = [])
        @title = title
        @content = content
      end

      def type
        @type ||= page_type_from_title
      end

      def add_content(item)
        @content << item
      end

      protected

      def page_type_from_title
        case title.downcase
        when /^list of officers/
          :crew
        when /^list of stores/
          :manifest
        when /\d{1,2}\s+\w+\s+\d{4}/
          :log_page
        else
          :unknown
        end
      end
    end
  end
end
