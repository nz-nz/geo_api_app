# frozen_string_literal: true

Rails.application.routes.draw do
  controller :geolocations do
    get '/geolocation/:address', action: 'show', constraints: { address: %r{[^/]+} }
    post '/geolocation', action: 'create'
    delete '/geolocation/:address', action: 'destroy', constraints: { address: %r{[^/]+} }
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
