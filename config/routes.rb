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
      get 'addashboard' => 'admin#addashboard'
    #resources :designs, only: [:new,:create,:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
