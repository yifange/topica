Topica::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      root :to => "application#ping"
      get "ping" => "application#ping"
      resources :comments, :posts, :users, :topics, :feeds
    end
  end
end
