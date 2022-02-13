# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :v1 do
    resources :weather_preferences, only: %i[index update]
    resources :weather_informations, only: %i[] do
      get :search, on: :collection
    end
  end
end
