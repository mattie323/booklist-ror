Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :authors do
        resources :books, only: [:index, :create]
      end
      resources :books, only: [:show, :update, :destroy]
    end
  end
  apipie
end