require_relative "view"
require_relative "recipe"
require_relative "service"
require "nokogiri"
require "open-uri"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display
  end

  def create
    recipe = Recipe.new(@view.ask_user_recipe_name, @view.ask_user_recipe_description, @view.ask_user_recipe_rating)
    @cookbook.add_recipe(recipe)
    display
  end

  def destroy
    display
    recipe_index = @view.ask_user_for_index("delete")
    @cookbook.remove_recipe(recipe_index)
    display
  end

  def import_recipe_from_internet
    ingredient = @view.ask_user_ingredient
    service = ScrapeAllrecipesService.new(ingredient)
    list_recipes = service.scrape_recipes_title
    list_link_recipes = service.scrape_recipes_link
    @view.show_user_recipes(ingredient, list_recipes)
    user_choice = @view.ask_user_recipe_choice
    recipe_link = list_link_recipes[user_choice]
    recipe_rating = service.scrape_recipes_rating(recipe_link)
    prep_time = service.scrape_recipes_prep_time(recipe_link)
    recipe = Recipe.new(list_recipes[user_choice], @view.ask_user_recipe_description, recipe_rating, "false", prep_time)
    @cookbook.add_recipe(recipe)
    display

    # Précédente méthode sans classer ScrapeAllrecipesService
    # ingredient = @view.ask_user_ingredient
    # list_recipes = scrape_recipes_title(ingredient)
    # list_link_recipes = scrape_recipes_link(ingredient)
    # @view.show_user_recipes(ingredient, list_recipes)
    # user_choice = @view.ask_user_recipe_choice
    # recipe_link = list_link_recipes[user_choice]
    # recipe_rating = scrape_recipes_rating(recipe_link)
    # prep_time = scrape_recipes_prep_time(recipe_link)
    # recipe = Recipe.new(list_recipes[user_choice], @view.ask_user_recipe_description, recipe_rating, "false", prep_time)
    # @cookbook.add_recipe(recipe)
    # display
  end

  def mark_as_done!
    display
    # 2. Ask user for index
    index = @view.ask_user_for_index("mark as done")
    # 3. Fetch task from repo
    recipe = @cookbook.find(index)
    # 4. Mark task as done
    recipe.mark_as_done!
    @cookbook.update!
    display
  end

  private

  def display
    @view.display_list(@cookbook.all)
  end

  # def scrape_recipes_title(ingredient)
  #   link = "https://www.allrecipes.com/search?q=#{ingredient}"
  #   doc = Nokogiri::HTML(URI.open(link).read, nil, "utf-8")
  #   # Output the 5 first results
  #   doc.search('.mntl-card-list-items .card__content:has(.recipe-card-meta) .card__title-text').map { |el| el.text }.first(5)
  # end

  # def scrape_recipes_link(ingredient)
  #   link = "https://www.allrecipes.com/search?q=#{ingredient}"
  #   doc = Nokogiri::HTML(URI.open(link).read, nil, "utf-8")
  #   # Output the 5 first links
  #   doc.search('.mntl-card-list-items').map { |el| el['href'] }.first(5)
  # end

  # def scrape_recipes_rating(link)
  #   doc = Nokogiri::HTML(URI.open(link).read, nil, "utf-8")
  #   # Output the 5 first results
  #   result = doc.search('#mntl-recipe-review-bar__rating_1-0')
  #   result.map { |el| el.text }.join.gsub("\n", "")
  # end

  # def scrape_recipes_prep_time(link)
  #   doc = Nokogiri::HTML(URI.open(link), nil, "utf-8")
  #   result = doc.search('.mntl-recipe-details__value')
  #   result.map { |el| el.text }[0]
  # end
end
