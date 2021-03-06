Rails.application.routes.draw do

  # get 'users/show'

  # get "/contacts/new" => 'contacts#new' 
  # post "/contacts" => 'contacts#create'
  put "/update_flag", to: 'contacts#update_active_flag'
  put "/delete_flag", to: 'contacts#delete'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users do
    resources :contacts
  end

  get "/users/:user_id/contacts/:id/sms" => 'contacts#sms', as: 'contact_sms'
  post "/users/:user_id/message" => 'users#save_birthday_message'

  # get "/users/:user_id/contacts/:id/delete" => 'contacts#delete', as: 'contact_delete'
  patch "/users/:user_id/contacts/:id/edit" => 'contacts#update', as: 'contact_update'

  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: "users#show"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
