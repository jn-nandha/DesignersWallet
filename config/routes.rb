Rails.application.routes.draw do

	root 'home#dashboard'
    devise_for :admins
    devise_for :users, controllers: 
    {
      registrations: 'users/registrations'
    }
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
      
      get 'follows', to: 'follows#index'
      get 'responds', to: 'follows#respond_to_req'
      post 'follows', to: 'follows#follow_req'
      put 'approved', to: 'follows#approved'
      delete 'delete', to: 'follows#delete_request'
      delete 'unfollow' , to: 'follows#unfollow'
      put 'block' , to: 'follows#blockusers' 
      get 'show' , to: 'profile#show'
      get 'user_profile',to: 'profile#user_profile'
      get 'follows/search', to: 'follows#search'
      get 'followings',to: 'follows#followings'
      get 'followers',to: 'follows#followers'

      get 'chats', to: 'chats#index'
      get 'chats/:id/msg', to: 'chats#msg', as: "personal_msg"
      post 'chats/send_msg', to: 'chats#send_msg', as: "send_msg"
      get  'chats/search', to: 'chats#search'
      get 'chats/design', to: 'chats#design'



     post 'feedbacks/like'
     post 'feedbacks/complain'

     
    #resources :designs, only: [:new,:create,:show]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
