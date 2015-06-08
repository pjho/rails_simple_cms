Rails.application.routes.draw do
  root 'posts#index'
  devise_for :admins

  resources :posts, :only => [:show,:index]

  get '/cms' => 'cms#index'

  namespace :cms do
    delete "/tagging/:post_id/:tag_id" => "taggings#destroy", as: 'delete_tagging_path'
    resources :pages, :except => [:show]
    resources :posts, :except => [:show]
    resources :admins, :controller => "admins"
    

    put '/tags/css' => 'tags#css'
    resources :tags, :only => ['index','update','destroy']
    get '/settings' => 'settings#index'
    put '/settings' => 'settings#update'
    get '/menus' => 'settings#menu'
  end

  get 'posts/tag/:tag', to: 'posts#index', as: "tag"
  
  resources :pages, :only => [:show,:home], :path => '' 
  
  #
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
