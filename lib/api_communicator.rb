require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  
  
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
    character_data = character_hash["results"].find { |data| data["name"].downcase == character_name }
    if character_data != nil  
      character_data["films"].collect do |url|
          JSON.parse(RestClient.get(url))
        end
    else
      get_character_movies_from_api(get_valid_char_name)
    end
end

def get_valid_char_name
  puts "Please enter a VALID character name:"
  character = gets.chomp.downcase
end


def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each_with_index do |film, i|
    puts "#{i+1}. Episode #{film["episode_id"]}: #{film["title"]}"
  end
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
