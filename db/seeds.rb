# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'yaml'

characters = YAML.load_file(Rails.root.join("db/seed_data/characters.yml"))

characters.each do |char|
  Character.find_or_create_by!(name: char["name"]) do |c|
    c.system_prompt = char["system_prompt"]
    c.image_url = char["image_url"]
  end
end
