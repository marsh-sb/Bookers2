Rails.application.routes.draw do
 devise_for :users
 root :to =>"homes#top"
 get "/home/about" => "homes#about"
 
 resources :users
 
 resources :books do
  resources :book_comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
 end
 
 post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
 post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
 resources :users, only: :show
 get 'users/:id/follower' => 'users#follower', as: 'user_follower'
 get 'users/:id/followed' => 'users#followed', as: 'user_followed'
end
