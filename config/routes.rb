Rails.application.routes.draw do
	
  devise_for :admins
   devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
      get 'design/new' ,to: 'design#new'
      post 'design/new' , to: 'design#create'
      get 'design/show'
      get 'follow/index'
      get 'follow/request' , to: 'follow#request'
    #resources :designs, only: [:new,:create,:show]
        root  to: 'dashboard#index'
        get '/manage', to: 'dashboard#index'
        post '/manage_user', to: 'dashboard#index'
        get '/manage_user', to: 'manage#manage_user'
end
