Rails.application.routes.draw do
  get 'users/logout' => 'users#logout', as: :users_logout
  get 'users/home' => 'users#home', as: :users_home
  get 'users/login' => 'users#login', as: :users_login
  get 'users' => 'users#index', as: :users_index
  get 'users/registre' => 'users#registre', as: :users_registre
  get 'users/:id' => 'users#show', as: :users_show
  get 'users/new' => 'users#new', as: :users_new
  get 'users/:id/edit' => 'users#edit', as: :users_edit
  post 'users/registre' => 'users#create'
  post 'users/login' => 'users#check'
  put 'users/:id' => 'users#update', as: :users_update
  delete 'users/:id' => 'users#delete', as: :users_delete


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
