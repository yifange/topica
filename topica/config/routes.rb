Topica::Application.routes.draw do
  namespace :api do
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
