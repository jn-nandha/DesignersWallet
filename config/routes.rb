Rails.application.routes.draw do
	
  devise_for :admins
   devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
      get 'design' ,to: 'design#new'
      post 'design' , to: 'design#create'
      get 'home/dashboard'
      get 'design/show'
      get 'follow/request' , to: 'follow#request'
    #resources :designs, only: [:new,:create,:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
