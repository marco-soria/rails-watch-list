# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'

# # URL de la API con el proxy REVISAR CODIGO
# api_url = 'http://tmdb.lewagon.com/movie/top_rated?limit=12'

# # Obtén los datos de la API
# movies_serialized = URI.open(api_url).read
# movies = JSON.parse(movies_serialized)['results']

# # Itera sobre las películas y crea registros en la base de datos
# movies.first(12).each do |movie|
#   Movie.create(
#     title: movie['title'],
#     overview: movie['overview'],
#     poster_url: "https://image.tmdb.org/t/p/original/#{movie['poster_path']}",
#     rating: movie['vote_average']
#   )
# end

# puts 'Seed finished'
puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

url = "http://tmdb.lewagon.com/movie/top_rated"
10.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie["title"],
      overview: movie["overview"],
      poster_url: "#{base_poster_url}#{movie["backdrop_path"]}",
      rating: movie["vote_average"]
    )
  end
end
puts "Movies created"
