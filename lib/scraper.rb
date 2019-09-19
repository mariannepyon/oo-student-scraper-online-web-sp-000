require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    html = open(index_url) #=> index_url = "../fixtures/student-site/index.html"
    list = Nokogiri::HTML(html)

    # This block returns a list of student names
    names = list.css(".student-name")
    names_array = []
    names.each do |item|
      names_array << item.text
    end
    names_array

    # This block returns a list of locations.
    locations = list.css(".student-location")
    location_array = []
    locations.each do |item|
      location_array << item.text
    end
    location_array

    # This block returns a list of student HTML pages.
    webpages = list.css(".student-card a[href]")
    webpage_array = []
    webpages.select do |item|
      webpage_array << item['href']
    end
    webpage_array


    master_array = []
    hash = {}
    x = 0
    names_array.each do |name|
      master_array << {:name => name, :location => location_array[x], :profile_url => webpage_array[x]}
      x = x + 1
    end
    master_array
  end

  def self.scrape_profile_page(profile_url)
    # students_hash = {}
    # html = Nokogiri::HTML(open(profile_url))
    # html.css("div.social-icon-controler a").each do |student|
    #     url = student.attribute("href")
    #     students_hash[:twitter_url] = url if url.include?("twitter")
    #     students_hash[:linkedin_url] = url if url.include?("linkedin")
    #     students_hash[:github_url] = url if url.include?("github")
    #     students_hash[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
    # end
    #     students_hash[:profile_quote] = html.css("div.profile-quote").text
    #     students_hash[:bio] = html.css("div.bio-content p").text
    # students_hash
  end

end
