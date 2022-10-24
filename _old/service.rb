class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # TODO: return a list of `Recipe` built from scraping the web.
  end

  def scrape_recipes_title
    link = "https://www.allrecipes.com/search?q=#{@keyword}"
    doc = Nokogiri::HTML(URI.open(link).read, nil, "utf-8")
    # Output the 5 first results of the recipes that have rating
    doc.search('.mntl-card-list-items .card__content:has(.recipe-card-meta) .card__title-text').map { |el| el.text }.first(5)
  end

  def scrape_recipes_link
    link = "https://www.allrecipes.com/search?q=#{@keyword}"
    doc = Nokogiri::HTML(URI.open(link).read, nil, "utf-8")
    # Output the 5 first links
    doc.search('.mntl-card-list-items').map { |el| el['href'] }.first(5)
  end

  def scrape_recipes_rating(link)
    doc = Nokogiri::HTML(URI.open(link).read, nil, "utf-8")
    # Output the 5 first results
    result = doc.search('#mntl-recipe-review-bar__rating_1-0')
    result.map { |el| el.text }.join.gsub("\n", "")
  end

  def scrape_recipes_prep_time(link)
    doc = Nokogiri::HTML(URI.open(link), nil, "utf-8")
    result = doc.search('.mntl-recipe-details__value')
    result.map { |el| el.text }[0]
  end

end
