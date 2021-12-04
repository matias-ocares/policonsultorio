Rails.application.routes.draw do
  root to: 'professionals#index'

  devise_for :users
  resources :professionals do
    resources :appointments do
      post :delete_all, on: :collection #Para elimintar todos los turnos de un professional
    end

  end
  resources :export
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
