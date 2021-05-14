Rails.application.routes.draw do
  get '/index', to: 'static#index'
  get '/contact', to: 'static#contact'
  get '/team', to: 'static#team'
  get '/gossip/:id', to: 'static#gossip'
  get '/author/:id', to: 'static#user'
  get '/welcome/:first_name', to: 'static#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :gossips do
    resources :comments
  end
  resources :users
  resources :cities
  resources :comments
  resources :sessions
end
