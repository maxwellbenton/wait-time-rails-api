Rails.application.routes.draw do
  
  

  resources :store_comments
  resources :comments
  namespace :api do
    namespace :v1 do
      resources :companies
      resources :wait_times
      resources :stores
      resources :users, only: [:index, :create, :update, :destroy]
      
      get   '/' => 'stores#search'
      get   'all/' => 'stores#index'
      
      post  'data/' => 'stores#data_search'
      post  'searchStores/' => 'stores#search'
      post  'createStore/' => 'stores#create'
      post  'wideSearchStores/' => 'stores#wide_search'
      post  'search/' => 'stores#query_search'
      post  'show/' => 'stores#show'

      post  'auth/', to: 'auth#create'
      get   'current_user/', to: 'auth#show'
      post  'user_data/', to: 'users#show'
      post  'create_user/', to: 'users#create'
      post  'create_feedback/', to: 'store_comments#create'
    end  
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
