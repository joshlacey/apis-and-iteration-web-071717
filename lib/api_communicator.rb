require 'rest-client'
require 'json'
require 'pry'

#looks up the data string and converts it into a hash from any url
def look_up(url)
  all = RestClient.get(url)
 hash = JSON.parse(all)
end 

#
def get_film_urls(character)
  character_hash = look_up('http://www.swapi.co/api/people/')
  film_urls = character_hash["results"].find do |element|
    element["name"].downcase == character
  end["films"]
end

def get_characters
  character_hash = look_up('http://www.swapi.co/api/people/')
  character_hash["results"].collect do |element|
    element["name"]
  end
end

def get_character_movies_from_api(character)
  film_urls = get_film_urls(character)
  film_urls.collect do |movie_url|
    look_up(movie_url)
  end
end


def parse_character_movies(films_hash)
  films_hash.collect do |movie|
    movie["title"]
  end
end

def show_character_movies(character)
  if get_characters.include? character
    films_hash = get_character_movies_from_api(character)
    puts parse_character_movies(films_hash)
  else
    puts "Have you even seen the movies?"
  end
end

"k"