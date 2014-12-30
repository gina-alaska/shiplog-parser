module Shiplogs
  module Parser
    class Html
      attr_accessor :url
      
      def initialize(url)
        @url = url
        @pages = []
      end
      
      def document
        @document ||= Nokogiri::HTML(open(@url))
      end
      
      def content
        document.css('div#content').first.children
      end
      
      def pages
        if @pages.empty?
          previous_node = nil
          current_page = nil
          content.css('p').each do |node|
            next if node.nil?
            
            if title_node?(node)
              if title_node?(previous_node)
                #found second title for current page
                current_page.title += " - #{title_content(node)}"
              else
                #found new page
                self.add_page(current_page)
                current_page = Page.new(title_content(node))
              end
            else
              current_page.add_content page_content(node) unless current_page.nil?
            end
            previous_node = node
          end
        end
        
        @pages
      end
      
      protected
      
      def add_page(page)
        return if page.nil?
        
        previous = @pages.last
        
        #check to see if the previous page has the same title as the current page
        if !previous.nil? and previous.title == page.title
          previous.content << "---"
          previous.content += page.content
        else
          @pages << page          
        end
      end
      
      def title_node?(node)
        return false if node.nil?
        node[:class] == 'center' and title_content(node).length > 0
      end
      
      def title_content(node)
        node.content.gsub("\n", " ").strip
      end
      
      def page_content(node)
        node.content.gsub("\n", " ").strip + "\n"
      end
    end
  end
end