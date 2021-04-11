class CharacterController < ApplicationController

    def show
        url_character = request.original_url
        character_name = url_character.split('/')[-1].split('.')[1]
        if character_name.include? "%20"
            character_name["%20"] = "+"
        end    
        
        character = find_character(character_name)
        @character = character

        @quotes = find_quotes(character_name)
        
    end
    
    def search
        url_character = request.original_url
        character_name = url_character.split('/')[-1].split('?')[1].split("=")[1].split("&")[0]
        if character_name.include? "%20"
            character_name["%20"] = "+"
        end    
        
        character = find_character(character_name)
        @character = character

        if @character.length == 10
          buscar = 1
          offset = 10
          while buscar == 1
            nuevos = find_character_offset(character_name, offset)
            if nuevos.length == 0
              buscar = 0
            end

            nuevos.each do |nuevo|
              @character.push(nuevo)
            end
            if nuevos.length < 10
              buscar = 0
            end
            offset += 10
          end
        end
    end

    private

    def request_api(url)
      response = RestClient.get url

      #return nil if response.status != 200

      result = JSON.parse response.to_str
    end

    def find_character(name)
      request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/characters?name=#{name}"
      )
    end

    def find_character_offset(name, offset)
      request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/characters?name=#{name}&limit=10&offset=#{offset}"
      )
    end

    def find_quotes(name)
      request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/quote?author=#{name}"
      )
    end

end
