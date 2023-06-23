Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "courses#index"
  get '/week', to: 'calendar#week'
  get '/month', to: 'calendar#month'
  resources :courses
  resources :users
end
