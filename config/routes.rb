Rails.application.routes.draw do
  get 'games/new'
  get '/new', to:  'games#new'
  post 'games/score'
  post '/score', to:  'games#score'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
