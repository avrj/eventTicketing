Rails.application.routes.draw do
  namespace :admin do
    resources :orders, except: [:new, :create]

    resources :tickets do
      post 'toggle_given_away', to: "tickets#toggle_given_away"
    end

    resources :seats do
      post 'toggle_given_away', to: "seats#toggle_given_away"
    end

    resources :ticket_types

    resources :customers

    delete 'customers', to: 'customers#destroy_multiple'
    delete 'seats', to: 'seats#destroy_multiple'
    delete 'orders', to: 'orders#destroy_multiple'
    delete 'tickets', to: 'tickets#destroy_multiple'
    delete 'admins', to: 'admins#destroy_multiple'
    delete 'users', to: 'users#destroy_multiple'

    resources :users

    get 'login', to: 'sessions#new'
    delete 'logout', to: 'sessions#destroy'

    root 'sessions#new'

    resource :session, only: [:new, :create, :delete]

  end

  namespace :customer do
    root 'orders#index'

    get 'login', to: 'sessions#new'

    delete 'logout', to: 'sessions#destroy'

    resources :orders, only: [:new, :create, :index, :show] do
      post 'pay', to: 'orders#pay'
    end

    resource :contact_information, only: [:show, :edit, :update]

    resource :session, only: [:new, :create, :delete]
  end

  post 'customers', to: "customer/customers#create"
  post 'customers/new', to: "customer/customers#new"

  get 'tickets', to: 'ticket_types#index'
  get 'seats', to: 'seats#index'
  get 'shopping_cart', to: 'shopping_cart#index'
  post 'shopping_cart/add_seats', to: 'shopping_cart#add_seats'
  post 'shopping_cart/add_tickets', to: 'shopping_cart#add_tickets'
  delete 'shopping_cart/delete_seat', to: 'shopping_cart#delete_seat'
  delete 'shopping_cart', to: 'shopping_cart#destroy'
  get 'shopping_cart/checkout', to: 'shopping_cart#checkout'
  post 'shopping_cart/update_qty', to: 'shopping_cart#update_qty'

  get 'login_or_register', to: 'shopping_cart#login_or_register'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'customer/seat_selector#index'

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
