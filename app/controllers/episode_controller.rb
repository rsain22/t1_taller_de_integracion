class EpisodeController < ApplicationController
    def index
        url_episode = request.original_url
        episode_id = url_episode.split('/')[-1].split('.')[1]
        
        episode = find_episodes(episode_id)

        @episode = episode

        @episode.each do |episode|
          fecha = episode['air_date']
          lista_fecha = fecha.split("T")[0].split("-")
          episode['air_date'] = "#{lista_fecha[2]}-#{lista_fecha[1]}-#{lista_fecha[0]}"
        end
        
    end
    
    private

    def request_api(url)
      response = RestClient.get url

      #return nil if response.status != 200

      result = JSON.parse response.to_str
    end

    def find_episodes(id)
      request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/episodes/#{id}"
      )
    end
end
