require 'rest-client'
require 'json'
require 'pry'

def look_up(url)
  all = RestClient.get(url)
 hash = JSON.parse(all)
end

def get_character_movies_from_api(character)
  character_hash = look_up('http://www.swapi.co/api/people/')

  film_urls = character_hash["results"].find do |element|
    element["name"] == character
  end["films"]

  film_urls.collect do |movie_url|
    binding.pry
    look_up(movie_url)
  end
end


def parse_character_movies(films_hash)
  films_hash.collect do |movie|
    movie["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

