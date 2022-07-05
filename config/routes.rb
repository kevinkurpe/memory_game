Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "game#index"

  get '/scores', to: 'game#scores'
  get '/:difficulty', to: 'game#index'
end
