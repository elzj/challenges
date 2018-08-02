Rails.application.routes.draw do
  get 'assignments/index'
  resources :collections

  resources :challenges do
    resources :assignments
    resources :prompts
    resources :signups
    resources :tag_sets
  end
  resources :prompts

  namespace :api, defaults: { format: :json } do
    resources :tags do
      collection { get :autocomplete }
    end
  end
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'collections#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
