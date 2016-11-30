Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :objs
    resources :categories
  end


  # namespace :api, path: 'somthing' do => /something => api::xxx
  namespace :api, path: '' do
    constraints(host: 'api.localhost') do
      resources :users
    end
  end  

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users do
    collection do
      get :edit_collection
      get :edit_like
      get :edit_subscribe
    end
  end

  resources :user_comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "objs#index"

  resources :objs do
    collection do
      post :post_index 
      get :editor
      get :about
    end
  end

  resources :tags
end
