Rails.application.routes.draw do
    devise_for :admins
    devise_for :users, controllers: 
    {
      registrations: 'users/registrations'
    }
      get 'application/count', to: 'application#count'
      post 'home/search', to: 'home#search', as: 'search'
      get 'home/dashboard'
      get 'home/error'
      get 'home/:design_id', to: 'home#image_info' , as: 'home'
      post 'home/:design_id', to: 'home#share_design', as: 'share_design'
      get 'user_profile',to: 'profile#user_profile'
      get 'profile/blockeduser_list'
      resources :designs, only: [:index,:new,:create]
      get 'designs/show_uploaded_design'
      get 'designs/favourites', to: 'favourites#fav_images', as: 'favourite_images'
      delete 'designs/del_design'
      post 'favourites/change_fav'
      get 'follows', to: 'follows#index'
  
      post 'follows', to: 'follows#follow_req'
      put 'approved', to: 'follows#approved'
      delete 'cancel', to: 'follows#cancel_request'
      delete 'revert', to: 'follows#revert_request'
      delete 'unfollow' , to: 'follows#unfollow'
      post 'block' , to: 'follows#blockuser'
      get 'follows/search', to: 'follows#search'
      get 'followings',to: 'follows#followings_list'
      get 'followers',to: 'follows#followers_list'
      delete 'follows/unblockuser'

      get 'user_profile',to: 'profile#user_profile'
      
      get 'chats', to: 'chats#index'
      get 'chats/:id/msg', to: 'chats#msg', as: "personal_msg"
      post 'chats/send_message', to: 'chats#send_message', as: "send_msg"
      get  'chats/search', to: 'chats#search'
      get 'chats/design', to: 'chats#design'
      post 'feedbacks/like'
      post 'feedbacks/complain'
    #resources :designs, only: [:new,:create,:show]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
