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
        @content << item unless item.nil? or item == ' '
      end
      
      protected
      
      def page_type_from_title
        case title
        when "List of Officers"
          :officers
        when /\d{1,2} \w+ \d{4}/
          :log_page
        else
          :unknown
        end
      end
    end
  end
end