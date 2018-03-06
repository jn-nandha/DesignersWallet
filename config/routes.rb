Rails.application.routes.draw do

  devise_for :admins
   devise_for :users, controllers: {
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
    
      
     



     
      
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
