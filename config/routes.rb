Rails.application.routes.draw do
  root to: "dashboard#index"

  devise_for :users,path: 'users',:controllers => { 
     :registrations => 'users/registrations',
    :passwords => "user_passwords",
    :invitations => 'users/invitations'
  } 
   
  devise_for :admins, path: 'admins',controllers:{ 
    sessions: "admins/sessions"
  }

  devise_scope :admin do
   get       "/admin"   =>   "admins/sessions#index"
   get       '/sign_out', to: 'admins/sessions#destroy'
   post      '/sign_out', to: 'admins/sessions#destroy'
   get       '/manage', to: 'admins/manage#index', as: :admin_root
   post       '/manage', to: 'admins/manage#index'
   get       '/manage_user', to: 'admins/manage#manage_user'
   post       '/manage_user', to: 'admins/manage#manage_user'
   post      '/delete',      to: 'admins/manage#delete_user'
   get      '/delete',      to: 'admins/manage#delete_user'
   get       '/users/invitation/new', to: 'users/invitations#new'
   patch     '/users/invitation/new', to: 'users/invitations#update'
   get        '/edit', to: 'users/registrations#edit'
   put '/edit' , to: 'users/registrations#update'
   get        '/update_user',      to: 'users/registrations#edit'
   post      '/update_user',      to:  'users/registrations#edit'

 end
 namespace :admin do
    resources :users
  end

 devise_scope :user  do
  resources :design
  get '/users/:id', to: 'manage#profile', as: 'user'
   get "/users/sign_in", to: "users/sessions#new"
   post '/users/sign_in', to: 'users/sessions#create'
   get '/logout', to: 'users/sessions#destroy'
   post '/logout', to: 'users/sessions#destroy'
  # get "/sign_up" => "devise/registrations#new", as: "new_user_registration" 
  # post "/sign_up" => "devise/registrations#create", as: "user_registration" 
end

 get    '/insert',      to: 'design#index'
 get    '/design_new',   to: 'design#new'
 get    '/profile',     to: 'admins/manage#profile'
 post   'design_new',   to: 'design#new'
 get   '/show_all_design', to: 'admins/manage#show_all_design'
 post   '/show_all_design', to: 'admins/manage#show_all_design'
 post   '/insert',      to: 'design#index' 
 post   '/profile',     to: 'admins/manage#profile'
 get   '/activate_user',      to: 'admins/manage#activate_user' 
 post   '/activate_user',     to: 'admins/manage#activate_user'
  
    end