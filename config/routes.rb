Rails.application.routes.draw do
  root to: 'trades#index'

  resources :trades, only: %i[index new create]

  namespace :api do
    namespace :v1 do
      get 'pokemons', to: 'pokemons#list', format: 'json'
      get 'trades/validate', to: 'trades#validate'
    end
  end
end
