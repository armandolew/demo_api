require 'open-uri'
  class TaskScraper

    def get_element(website)

      doc = open(website)

      site = Nokogiri::HTML.parse(doc)
      if site
        element = site.at_css("h1").text
      else
        element = nil
      end
    end

end