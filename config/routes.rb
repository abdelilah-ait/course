Rails.application.routes.draw do
  get 'users/logout' => 'users#logout', as: :users_logout
  get 'users/home' => 'users#home', as: :users_home
  get 'users/login' => 'users#login', as: :users_login
  get 'users' => 'users#index', as: :users_index
  post 'users/login' => 'users#check'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
