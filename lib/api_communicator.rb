require 'rest-client'
require 'json'
require 'pry'

#looks up the data string and converts it into a hash from any url
def look_up(url)
  all = RestClient.get(url)
 hash = JSON.parse(all)
end 

#gets the film urls to be looked up
def get_film_urls(character)
  character_hash = look_up('http://www.swapi.co/api/people/')
  film_urls = character_hash["results"].find do |element|
    element["name"].downcase == character
  end["films"]
end

#returns a list of every character in the movies
def get_characters
  character_hash = look_up('http://www.swapi.co/api/people/')
  character_hash["results"].collect do |element|
    element["name"]
  end
end

#gets the film urls to be looked up
def get_character_movies_from_api(character)
  film_urls = get_film_urls(character)
  film_urls.collect do |movie_url|
    look_up(movie_url)
  end
end

#returns the titles of each film from the character
def parse_character_movies(films_hash)
  films_hash.collect do |movie|
    movie["title"]
  end
end

#returns an array of movie titles if the character is in one of the movies.
def show_character_movies(character)
  if get_characters.include? character
    films_hash = get_character_movies_from_api(character)
    puts parse_character_movies(films_hash)
  else
    puts "Have you even seen the movies?"
  end
end
