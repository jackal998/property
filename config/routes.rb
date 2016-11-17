Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :objs    
  end

  devise_for :users

  resources :users

  resources :user_comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "objs#index"

  resources :objs do
    collection do
      post :post_index
      get :about

    end
  end
end
