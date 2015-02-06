Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, path: '/'
  get '/' => 'users#index'
  get 'tournaments/:slug' => 'tournaments#show', as: 'tournament'
  post 'tournaments/:slug/join' => 'tournaments#create', as: 'join_tournament'
  delete 'tournaments/:slug/leave' => 'tournaments#destroy', as: 'leave_tournament'

  namespace :api, defaults: { format: :json } do
    get 'check' => 'updates#index'
    get 'check/:name' => 'updates#show'

    get 'schedule' => 'stages#index'

    get 'tournaments/' => 'tournaments#index'
    get 'tournaments/:slug' => 'tournaments#show'

    resources :stages, only: [:index,:show]
    resources :events, only: [:index,:show]
  end

  namespace :admin do
    get 'tournaments' => 'tournaments#index', as: 'tournaments'
    get 'tournaments/:slug' => 'tournaments#show', as: 'show_tournament'
    put 'tournaments/:slug/start' => 'tournaments#start', as: 'start_tournament'
    put 'tournaments/:slug/cancel' => 'tournaments#cancel', as: 'cancel_tournament'
    get 'tournaments/:slug/:round/:match' => 'tournaments#match', as: 'tournament_match'
    put 'tournaments/:slug/:round/:match' => 'tournaments#match_result', as: 'tournament_match_result'
    post 'tournaments/:slug/:round/:match' => 'tournaments#call_match', as: 'tournament_call_match'
    patch 'tournaments/:slug/:round/:match' => 'tournaments#start_match', as: 'tournament_start_match'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

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
