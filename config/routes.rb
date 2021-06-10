Rails.application.routes.draw do
  root 'games#index'

  resources :teams
  resources :games do
    resources :notes, only: [ :index, :new, :create, :destroy ]
    resources :supporters, only: [ :new, :create, :destroy ]
    resources :comments, only: [ :new, :create ]
    member do
      get 'edit_score'
      get 'edit_quick'
      post 'edit_quick', to: 'games#update_quick'
      get 'widget'
      get 'widget/notes', to: 'notes#widget'
      post 'update_score'
    end
  end
  get '/games/:id/:timestamp/scoreboard', to: 'games#scoreboard', as: 'scoreboard_game'

  resources :users, only: [ :index, :show ]

  resources :sessions, only: [:create]
  get '/logout', to: 'sessions#clear'
  # Omniauth success callback
  get '/auth/:provider/callback', to: 'sessions#create'

  get '/impressum', to: 'application#impressum'
  get '/datenschutz', to: 'application#datenschutz'
  get '/datenloeschung', to: 'application#datenloeschung'
  get '/nutzungsbedingungen', to: 'application#nutzungsbedingungen'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
