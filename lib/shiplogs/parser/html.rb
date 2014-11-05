module Shiplogs
  module Parser
    class Html
      attr_accessor :url
      
      def initialize(url)
        @url = url
      end
      
      def document
        @document ||= Nokogiri::HTML(open(@url))
      end
      
      def content
        document.css('div#content').first.children
      end
      
      def pages
        if @pages.nil?
          @pages = []
        
          current_page = nil
          content.css('p').each do |node|
            if node[:class] == 'center'
              #found title item
              unless current_page.nil?
                @pages << current_page 
              end
              
              current_page = Page.new(title_content(node))
            elsif !current_page.nil? and !node.nil?
              current_page
              current_page.add_content page_content(node)
            end
          end
        end
        
        @pages
      end
      
      def title_content(node)
        node.content.gsub("\n", " ")
      end
      
      def page_content(node)
        node.content.gsub("\n", " ")
      end
    end
  end
end