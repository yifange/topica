Topica::Application.routes.draw do
  # The namespace for the APIs
  namespace :api do
    # The namespace for API v1 
    namespace :v1 do
      get "home" => "home#index"
      post "login" => "user_sessions#create"
      post "signup" => "users#create"
      get "logout" => "user_sessions#destroy"
      root :to => "application#ping"
      get "ping" => "application#ping"
      
      resources :comments, :only => [:destroy, :update, :show]

      resources :posts, :only => [:destroy, :update, :show] do
        resources :comments, :only => [:index, :create, :destroy, :update]
        get "/favors" => "favors#all_favorers"
        get "/topics" => "categories#all_topics"
        post "/topics/delete" => "categories#destroy"
        post "/topics" => "categories#create"
      end
      
      resources :topics, :only => [:destroy, :update, :show] do
        get "/followers" => "topics#all_following_users"
        get "/posts" => "categories#all_posts"
      end
      resources :feeds, :only => [:update, :destroy, :show] do
        get "/topics" => "feeds#all_topics"
      end
      resources :users, :only => [:update, :destroy, :index, :show] do
        
        # favors
        get "/favors/:post_id" => "favors#create"
        post "/favors" => "favors#create"
        delete "/favors/:post_id" => "favors#destroy"

        get "/favors" => "users#all_favoring_posts" 

        get "/comments" => "users#all_comments"
        
        resources :posts, :only => [:create, :index, :destroy, :update]

        get "/follows" => "users#all_following_topics" # following topics
        get "/followships/:topic_id" => "followships#create"
        post "/followships" => "followships#create"
        delete "/followships/:topic_id" => "followships#destroy"

        resources :topics, :only => [:index, :create, :destroy, :update]

        resources :feeds, :only => [:index, :create, :destroy, :update]
      end
    end
  end
  match "*path", :to => "api/v1/errors#routing_error", :via => [:get, :post, :put, :delete, :patch]
end
