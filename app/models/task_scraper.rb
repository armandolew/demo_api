require 'open-uri'
  class TaskScraper

    ELEMENTS = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6']

    def get_element(website)
      html_element = 'p'
      doc = open(website)

      site = Nokogiri::HTML.parse(doc)
      if site
        ELEMENTS.each do |element|
          if site.css(element).count > 0
            html_element = element
          end
        end
        tag = site.at_css(html_element).text.to_s
      else
        tag = nil
      end
    end

end