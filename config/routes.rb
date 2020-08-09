Rails.application.routes.draw do
  get 'buys/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end  # devise_for :users

  root "items#index"
  resources :items, only: [:index, :show, :new, :create] do 
    resources :comments, only: [:create, :destroy]
  end
  resources :buy, only: :new
end
