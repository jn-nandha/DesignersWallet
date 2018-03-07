Rails.application.routes.draw do

	root 'follow#dashboard'
    devise_for :admins
    devise_for :users, controllers: 
    {
      registrations: 'users/registrations'
    }
      get 'home/dashboard'
      post 'home/search', to: 'home#search'
      get 'home/error'
      get 'home/:design_id', to: 'home#image_info' , as: 'home'


      resources :designs, only: [:index,:new,:create]
      get 'designs/show_uploaded_design'
      delete 'designs/del_design'
            
      post 'favourites/change_fav'
    
    get 'follow', to: 'follow#index'
    get 'responds', to: 'follow#respond_to_req'
    post 'follow', to: 'follow#follow_req'
    put 'approved', to: 'follow#approved'
    delete 'delete', to: 'follow#delete_request'
    delete 'unfollow' , to: 'follow#unfollow'
    put 'block' , to: 'follow#blockusers'
    get 'show' , to: 'profile#show'
    get 'followings',to: 'follow#followings'
    get 'followers',to: 'follow#followers'
    #resources :designs, only: [:new,:create,:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
