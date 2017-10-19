Rails.application.routes.draw do
  resources :invitations do
  end
  resources :markers do
    get :autocomplete_user_email, :on => :collection
    member do
      get 'invite'
    end

    collection do
      get 'partial'
      get 'approve_member'
      get 'reject_member'
    end
  end
  resources :tracks, controller: 'markers'
  #get 'template/index'

  resources :template, only: [:index]
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    :registrations => "users/registrations",
                                    :omniauth_callbacks => "users/omniauth_callbacks"}
  #devise_for :users
  resources :people
  root :to => 'template#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
