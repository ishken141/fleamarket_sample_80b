Rails.application.routes.draw do
  get '/users/item.user.id', to: 'users#show'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get  'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end


  root "items#index"

  resources :users, only: [:new, :show, :edit, :update] do
    resources :profiles, only: [:edit, :update]
    collection do
      get :likes
    end
    member do
      get :followings, :followers
    end
  end

  resources :items do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get   "search"
      get   "detail"
      match "detail" => "items#detail",   via: [:get, :post]
      get   'get_category_children',      defaults: { format: 'json' }
      get   'get_category_grandchildren', defaults: { format: 'json' }
      get   "get_delivery_fee",           defaults: { format: 'json' }
    end

    member do
      get   "get_category_children",      defaults: { format: "json" }
      get   "get_category_grandchildren", defaults: { format: "json" }
      get   "get_delivery_fee",           defaults: { format: 'json' }
      get   "reserve"
      patch "reserved"
      patch "reserve_cancel"
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
      get 'done', to: 'card#done'
      # get 'purchase', to: 'card#purchase'
    end
    # member do
    # end
  end
  Rails.application.routes.draw do
    resources :relationships, only: [:create, :destroy]
  end
end
