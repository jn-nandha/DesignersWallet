Rails.application.routes.draw do

    root 'home#dashboard'

    devise_for :admins
    devise_for :users, controllers: 
    {
      registrations: 'users/registrations'
    }
      get 'application/count', to: 'application#count'
      
      resources :home do
        collection do
          post 'search', as: 'search'
          get 'dashboard'
          get 'error'
          get ':design_id', to: 'home#image_info', as: :image_info
          post ':design_id', to: 'home#share_design', as: :share_design
        end
      end
      get 'user/:id/profile',to: 'profile#user_profile', as: 'user_profile'
      get 'profile/blockeduser_list'
      resources :designs, only: [:index,:new,:create]
      get 'designs/show_uploaded_design'
      get 'designs/favourites', to: 'favourites#fav_images', as: 'favourite_images'
      delete 'designs/del_design'
      post 'favourites/change_fav'
  
      resources :follows, only:[:index] do
        collection do
          post ':id/toggle', to: 'follows#follow_toggle', as: 'toggle'
          post ':id/cancel', to: 'follows#cancel_request', as: 'cancel'
          post ':id/accept', to: 'follows#accept_request', as: 'accept'
          post ':id/block', to: 'follows#block_user', as: 'block'
          delete ':id/unblock', to: 'follows#unblock_user', as: 'unblock'
          get 'search', to: 'follows#search_users'
          get 'followings_list'
          get 'followers_list'
        end
      end    
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
