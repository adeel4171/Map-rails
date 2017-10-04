Rails.application.routes.draw do
  resources :invitations
  resources :markers do
    member do
      get 'invite'
    end
  end
  resources :tracks, controller: 'markers'
  #get 'template/index'

  resources :template, only: [:index]
  devise_for :users 
  resources :people
  root :to => 'template#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
