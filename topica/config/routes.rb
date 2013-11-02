Topica::Application.routes.draw do
  # The namespace for the APIs
  namespace :api do
    # The namespace for API v1 
    namespace :v1 do
      post "login" => "user_sessions#create"
      post "signup" => "users#create"
      get "logout" => "user_sessions#destroy"
      root :to => "application#ping"
      get "ping" => "application#ping"

      resources :posts, :only => [] do
        resources :comments, :only => [:index, :create, :destroy, :update]
        get "/favors" => "favors#all_favorers"
        get "/topics" => "categories#all_topics"
      end
      
      resources :topics, :only => [] do
        get "/followers" => "followship#all_following_users"
        get "/posts" => "categories#all_posts"
        resources :posts, :excpet => [:index, :new, :edit] do
          resources :comments, :except => [:new, :edit, :destroy]
        end
      end
      resources :users, :except => [:new, :edit] do
        
        # favors
        get "/favors/:post_id" => "favors#create"
        post "/favors" => "favors#create"
        delete "/favors/:post_id" => "favors#destroy"
        get "/favors" => "favors#index" 

        resources :comments, :except => [:new, :edit]

        resources :posts, :except => [:new, :edit] do
          post "/topics/delete" => "categories#destroy"
            resources :posts, :except => [:new, :edit, :destroy] do
              resources :comments, :except => [:new, :edit]
            end
          post "/topics" => "categories#create"
        end


        # following topics
        get "/follows" => "followship#all_following_topics"

        resources :topics, :except => [:new, :edit]

        resources :feeds, :except => [:new, :edit] do
          get "/topics" => "feeds#all_topics"
        end

      end
    end
  end
  match "*path", :to => "api/v1/errors#routing_error", :via => [:get, :post, :put, :delete, :patch]
end
