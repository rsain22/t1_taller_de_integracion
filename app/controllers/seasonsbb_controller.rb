class SeasonsbbController < ApplicationController
    def index
        episodes = find_episodes()
    
        @episode = episodes
        
        url_season = request.original_url
        temporada = url_season.split('/')[-1].split('.')[1]
        
        episodes_season = []

        episodes.each do |episode|
            if episode['season'] == temporada
                episodes_season.push(episode)
            end
        end
        @episode = episodes_season
    end
    
    private

    def request_api(url)
      response = RestClient.get url

      #return nil if response.status != 200

      result = JSON.parse response.to_str
    end

    def find_episodes()
      request_api(
        'https://tarea-1-breaking-bad.herokuapp.com/api/episodes/?series=Breaking+Bad'
      )
    end
end
