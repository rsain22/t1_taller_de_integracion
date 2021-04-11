require 'net/http'
require 'json'
require 'rest-client'


class MainController < ApplicationController

    def index
        episodes = find_episodes()
    
        @episode = episodes

        @seasonsbb = []
        @seasonsbc = []

        @episode.each do |episode|
            if episode['series'] == "Better Call Saul"
                if not @seasonsbc.include?(episode['season'])
                    @seasonsbc.push(episode['season'])
                end
            elsif episode['series'] == "Breaking Bad"
                if not @seasonsbb.include?(episode['season'])
                    @seasonsbb.push(episode['season'])
                end
            end
        # ...
        end
      end
    
    private

    def request_api(url)
      response = RestClient.get url

      #return nil if response.status != 200

      result = JSON.parse response.to_str
    end

    def find_episodes()
      request_api(
        'https://tarea-1-breaking-bad.herokuapp.com/api/episodes/'
      )
    end
end


