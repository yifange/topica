Topica::Application.routes.draw do
  # The namespace for the APIs
  namespace :api do
    # The namespace for API v1 
    namespace :v1 do
      post "login" => "user_sessions#create"
      get "logout" => "user_sessions#destroy"
      root :to => "application#ping"
      get "ping" => "application#ping"
      resources :users do
        resources :topics
        resources :feeds do
          resource :topics
        end
        resources :posts do
          resources :comments
        end
      end
      resources :comments, :posts, :users, :topics, :feeds
    end
  end
  match "*path", :to => "application#routing_error", :via => [:get, :post, :put, :delete, :patch]
end
