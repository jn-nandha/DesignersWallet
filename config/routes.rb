Rails.application.routes.draw do
	
    devise_for :admins
    devise_for :users, controllers: 
    {
      registrations: 'users/registrations'
    }
    get 'design/new' ,to: 'design#new'
    post 'design/new' , to: 'design#create'
    get 'design/show'
    
    get 'follow', to: 'follow#index'
    get 'responds', to: 'follow#respond_to_req'
    post 'follow', to: 'follow#req'
    post 'approved', to: 'follow#approved'
    post 'delete_request', to: 'follow#delete_request'

    #resources :designs, only: [:new,:create,:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
