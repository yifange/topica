Topica::Application.routes.draw do
  get "user_sessions/new"
  get "user_sessions/create"
  get "user_sessions/destroy"
  # The namespace for the APIs
  namespace :api do
    # The namespace for API v1 
    namespace :v1 do
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
end
