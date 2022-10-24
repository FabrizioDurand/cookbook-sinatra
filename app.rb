require "sinatra"
require "sinatra/reloader" if development?
require_relative "cookbook"
require "pry-byebug"
require "better_errors"
set :bind, "0.0.0.0"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get "/" do
    erb :index
    cookbook = Cookbook.new('recipes.csv')
    @recipes = cookbook.recipes
end

get "/new" do
  erb :new
  # @recipes =
end

get "/about" do
  erb :about
end

get "/team/:username" do
  puts params[:username]
  "The username is #{params[:username]}"
end
