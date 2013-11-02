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

      resources :users, :except => [:new, :edit] do
        
        # favors
        get "/favors/:post_id" => "favors#create"
        post "/favors" => "favors#create"
        delete "/favors/:post_id" => "favors#destroy"
        get "/favors" => "favors#index" 

        resources :comments, :except => [:new, :edit]

        resources :posts, :except => [:new, :edit] do
          post "/topic/delete" => "categories#destroy"
          post "/topics" => "categories#create"
        end

        resources :topics, :except => [:new, :edit] do
          get "/posts" => "categories#all_posts"
          resources :posts, :except => [:new , :edit, :destroy] do
            resources :comments, :except => [:new, :edit, :destroy]
          end
        end

        resources :feeds, :except => [:new, :edit] do
          resources :topics, :except => [:new, :edit, :destroy] do
            resources :posts, :except => [:new, :edit, :destroy] do
              resources :comments, :except => [:new, :edit]
            end
          end
        end

      end
    end
  end
  match "*path", :to => "api/v1/errors#routing_error", :via => [:get, :post, :put, :delete, :patch]
end
