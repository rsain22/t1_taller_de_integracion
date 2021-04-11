Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'main#index'
  get '/search', to: 'character#search', as: 'character_search'
  get 'seasonsbb', to: 'seasonsbb#index', as: 'seasonsbb_index'
  get 'seasonsbcs', to: 'seasonsbcs#index', as: 'seasonsbcs_index'
  get 'episode', to: 'episode#index', as: 'episode_index'
  get 'character', to: 'character#show', as: 'character_show'
end
