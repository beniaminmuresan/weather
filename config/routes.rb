# frozen_string_literal: true

Rails.application.routes.draw do
  resources :weather_preferences, only: %i[index update]
  resources :weather_informations, only: %i[] do
    get :search, on: :collection
  end
end
