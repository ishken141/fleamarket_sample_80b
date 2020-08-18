Rails.application.routes.draw do
  # get 'card/new'
  # get 'card/show'
  get '/users/item.user.id', to: 'users#show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end  # devise_for :users

  root "items#index"
  
  resources :users, only: [:show, :edit, :update] do 
    resources :profiles, only: [:new, :create, :edit, :update] 
    collection do 
      get :likes 
    end 
  end
  
  resources :items do  
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do 
      get "search"
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' } 
    end
    member do
      get "get_category_children",        defaults: { format: "json" }
      get "get_category_grandchildren",   defaults: { format: "json" }
      # get "get_selected_category",        defaults: { format: "json" }
    end
  end

  resources :buys, except: [:new] do
    member do
      post 'pay', to: 'buys#pay'
      get 'new', to: 'buys#new'
      get 'done', to: 'buys#done'
    end
  end

  # クレカに関する記述
  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
end
