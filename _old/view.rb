class View
  def display_list(recipes)
    if recipes.empty?
      puts "Aucune recette disponible"
    else
      recipes.each_with_index do |recipe, index|
        p recipe.done
        if recipe.done == "true" || recipe.done == true
          rep = "X"
        else
          rep = " "
        end
        puts "[#{rep}] #{index + 1} - #{recipe.name}: #{recipe.description} (#{recipe.rating}/5) - Preparation time: #{recipe.prep_time}"
      end
    end
  end

  def ask_user_recipe_name
    puts " "
    puts "What is the name of the recipe you want to add?"
    gets.chomp
  end

  def ask_user_recipe_description
    puts " "
    puts "What is the description of the recipe you want to add?"
    gets.chomp
  end

  def ask_user_recipe_rating
    puts " "
    puts "What rating do you want apply to this recipe (out of 5)?"
    rating = gets.chomp.to_i
    while rating.negative? || rating > 5
      puts "Your rating must be between 0 and 5. Enter a new rating please:"
      rating = gets.chomp.to_i
    end
    rating
  end

  def ask_user_for_index(action)
    puts " "
    puts "What recipe do you want to #{action}?"
    gets.chomp.to_i - 1
  end

  def ask_user_ingredient
    puts "What ingredient would you like a recipe for?"
    gets.chomp.downcase
  end

  def show_user_recipes(ingredient, list_recipes)
    puts " "
    puts "Looking for \"#{ingredient}\" recipes on the Internet..."
    puts " "
    list_recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe}"
    end
  end

  def ask_user_recipe_choice
    puts " "
    puts "Which recipe would you like to import? (enter index) "
    gets.chomp.to_i - 1
  end
end
