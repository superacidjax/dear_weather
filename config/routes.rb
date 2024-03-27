Rails.application.routes.draw do

  root 'home#index'
  get 'weather' => 'home#get_weather', as: :get_weather
  get 'refresh' => 'home#refresh', as: :refresh_weather

  get 'up' => 'rails/health#show', as: :rails_health_check
end
