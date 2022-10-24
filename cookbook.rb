require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file_path)
    # loads existing Recipe from the CSV
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    # returns all the recipes
    @recipes
  end

  def add_recipe(recipe)
    # adds a new recipe to the cookbook
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    # removes a recipe from the cookbook
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def find(index)
    @recipes[index]
  end

  def update!
    save_csv
  end

  private

  def load_csv
    # load the csv file and save each line to recipes array
    CSV.foreach(@csv_file_path) do |row|
      # recipe = Recipe.new(row[0], row[1])
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
      # @recipes << recipe
    end
  end

  def save_csv
    # save all the recipes on each line of the csv (it erase the file)
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done, recipe.prep_time]
      end
    end
  end
end


# test = Cookbook.new("lib/recipes.csv")
# p test.all
# recipe = Recipe.new("gateau", "chocolat")
# test.add_recipe(recipe)
# p test.all
# test.remove_recipe(3)
# p test.all
