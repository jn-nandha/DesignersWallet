  Rails.application.routes.draw do
  root 'home#dashboard'

  devise_for :users,path: 'users',:controllers => { 
    :registrations => 'users/registrations',
    :passwords => "user_passwords",
    :invitations => 'users/invitations'
  } 

  devise_for :admins, path: 'admins',controllers:{ 
    sessions: "admins/sessions"
  }
  
  devise_scope :admin do

    get 'home/dashboard'
    post 'home/search', to: 'home#search'
    get 'home/error'
    get 'show' , to: 'profile#show'
    get 'home/:design_id', to: 'home#image_info' , as: 'home'

    get 'user_profile',to: 'profile#user_profile'
    resources :designs, only: [:index,:new,:create]
    get 'designs/show_uploaded_design'
    delete 'designs/del_design'
    post 'favourites/change_fav'

    get 'follow', to: 'follows#index'
    get 'responds', to: 'follows#respond_to_req'
    post 'follow', to: 'follows#follow_req'
    put 'approved', to: 'follows#approved'
    delete 'delete', to: 'follows#delete_request'
    delete 'unfollow' , to: 'follows#unfollow'
    put 'block' , to: 'follows#blockusers' 
    get 'show' , to: 'profile#show'
    get 'user_profile',to: 'profile#user_profile'
    get 'follow/search', to: 'follows#search'
    get 'followings',to: 'follows#followings'
    get 'followers',to: 'follows#followers'

    get 'chats', to: 'chats#index'
    get 'chats/:id/msg', to: 'chats#msg', as: "personal_msg"
    post 'chats/send_msg', to: 'chats#send_msg', as: "send_msg"
    get  'chats/search', to: 'chats#search'
    get 'chats/design', to: 'chats#design'
    #  ...............................................................

    get         "/admin"     =>   "admins/sessions#index"
    get         '/manage',   to: 'admins/manage#index', as: :admin_root
    post        '/manage',   to: 'admins/manage#index'
    get         '/manage_user', to: 'admins/manage#manage_user'
    post        '/manage_user', to: 'admins/manage#manage_user'
    post        '/delete',      to: 'admins/manage#delete_user'
    get         '/delete',      to: 'admins/manage#delete_user'
    get         '/users/invitation/new', to: 'users/invitations#new'
    patch       '/users/invitation/new', to: 'users/invitations#update'
    get         '/edit',     to: 'users/registrations#edit'
    put         '/edit' ,    to: 'users/registrations#update'
    get         '/update_user',      to: 'users/registrations#edit'
    post        '/update_user',      to:  'users/registrations#edit'
    get     'manage/activate_user', to: 'manage#activate_user' 
    get     '/update_activation', to: 'admins/manage#update_activation' 
    post     '/update_activation', to: 'admins/manage#update_activation'
    get     '/search', to: 'admins/manage#search'
    post     '/search', to: 'admins/manage#search'
    get    '/profile',     to: 'admins/manage#profile'
    post   '/profile',     to: 'admins/manage#profile'
    get   '/activate_user',      to: 'admins/manage#activate_user' 
    post   '/activate_user',     to: 'admins/manage#activate_user'
    get   '/show_all_design', to: 'admins/manage#show_all_design'
    post   '/show_all_design', to: 'admins/manage#show_all_design'
 
  end

end

