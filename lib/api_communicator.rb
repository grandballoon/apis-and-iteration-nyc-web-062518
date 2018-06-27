require 'rest-client'
require 'JSON'
require 'pry'

#Get a hash with all the data for a given character
def get_character_data(array, character)
  array.find do |char|
    char["name"].downcase == character
    #binding.pry
  end
end

#Get an array full of hashes with data for all the films
def get_film_data(array)
  film_data = []
  array.each do |url|
  api_request = RestClient.get(url)
  nice_hash = JSON.parse(api_request)
  film_data << nice_hash
  end
  film_data
end

#Puts out the titles of each movie
def parse_character_movies(array)
  array.map do |flick|
    puts flick["title"]
  end
end



def get_character_movies_from_api(character)
  #make the web request
  current_character = ""
url = "http://www.swapi.co/api/people/?page=1"
while current_character.downcase != character.downcase
  all_characters = RestClient.get(url)
  character_hash = JSON.parse(all_characters)
  array_of_hashes = character_hash["results"]
  current_character_hash = array_of_hashes.find do |character_hash|
    character_hash["name"].downcase == character.downcase

  end
  #binding.pry
  if current_character_hash
  current_character = current_character_hash["name"]
  end
  #binding.pry
  #if character_hash["next"] == nil
    #break
  #else
  url = character_hash["next"]
#end

#binding.pry
  end

  data = get_character_data(array_of_hashes, character.downcase)
  #binding.pry

  movie_urls = data["films"]
  movie_facts = get_film_data(movie_urls)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
