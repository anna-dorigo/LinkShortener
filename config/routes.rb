Rails.application.routes.draw do
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/links" => "links#create"

  get "/display" => "links#display"
  get "/s/:lookup_code" => "links#redirect"
  get "/changeState/:id" => "links#change_state"

  resources :links, only: [:create, :destroy]
end
