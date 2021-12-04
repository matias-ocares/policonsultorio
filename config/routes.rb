Rails.application.routes.draw do
  resources :usuarios
  root to: 'professionals#index'

  devise_for :users
  resources :professionals do
    resources :appointments do
      post :delete_all, on: :collection #Para elimintar todos los turnos de un professional
    end

  end

  post '/usuarios/new', to:'usuarios#create'
  post '/usuarios/:id/edit' , to:'usuarios#update'

  resources :export
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
