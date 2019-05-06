Rails.application.routes.draw do
  resources :users, except: [:show, :edit, :destroy] do 
    resources :heros, only: [:new]
  end

  resources :heros

  resources :teams do
    resources :heros, only: [:index]
  end

  resources :sessions, only: [:create, :destroy]

  get '/register' => 'users#new'
  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  get '/account' => 'users#show'
  get '/account/edit' => 'users#edit'
  root 'welcome#home'

  delete '/users/:id' => 'users#destroy'

  # OAuth Facebook route
  get '/auth/facebook/callback' => 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
