Rails.application.routes.draw do
	
  devise_for :admins
   devise_for :users, controllers: {
        registrations: 'users/registrations'
<<<<<<< HEAD
       }
     devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  resources :user, :controller => "user"
  root to: 'manage#index'

        get    '/insert',      to: 'design#index'
        get    '/design_new',   to: 'design#new'
        get   '/show_design', to: 'design#show'
        get    '/delete',      to: 'manage#delete_user'
        get    '/manage',      to: 'dashboard#index'
        get    '/manage_user', to: 'manage#manage_user'
        get    '/profile',     to: 'manage#profile'
        
        post   'design_new',   to: 'design#new'
       # post   'image_url',    to:  'design#image_url'
        post   '/show_design', to: 'design#show'
        post   '/insert',      to: 'design#index' 
        post   '/delete',      to: 'manage#delete_user'
        post   '/profile',     to: 'manage#profile'
        post   '/manage_user', to: 'dashboard#index'
end








#https://github.com/plataformatec/devise/wiki/How-To:-Manage-Users-with-an-Admin-Role-(CanCan-method)
=======
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
>>>>>>> f76ffd52b579afa948ebecdf93edaa51ee39b8f5
