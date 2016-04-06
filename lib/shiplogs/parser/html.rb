module Shiplogs
  module Parser
    class Html
      attr_accessor :url

      INVALID_TITLE_CHARACTERS = /[\r\n]+/
      CONVERT_TO_SPACE_CHARACTERS = /[\n\s]+/

      def initialize(url)
        @url = url
        @pages = []
        @content = nil
        @content_containers = ['div#content', 'td#logs']
      end

      def document
        @document ||= Nokogiri::HTML(open(@url))
      end

      def content
        while @content.nil?
          el = @content_containers.shift
          @content = document.css(el).first
        end
        @content.children
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
        node.content.gsub(CONVERT_TO_SPACE_CHARACTERS, ' ').gsub(INVALID_TITLE_CHARACTERS, '').strip
      end

      def page_content(node)
        node.content.gsub(CONVERT_TO_SPACE_CHARACTERS, ' ').strip + "\n"
      end
    end
  end
end
