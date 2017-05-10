Rails.application.routes.draw do
  root :to => "pages#index"
  get 'dashboard' => 'pages#dashboard', as: :dashboard

  #pagination
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  #session
  get 'register' => 'guild_applications#new', as: :register
  post 'sign_in' => 'sessions#sign_in', as: :sign_in
  get  'sign_out' => 'sessions#sign_out', as: :sign_out
  get  'forgot_password' => "sessions#forgot_password", as: :forgot_password
  post 'send_password_link' => "sessions#send_password_link", as: :send_password_link

  #Profile
  get 'profile/:username' => "profiles#show", as: :show_profile

  #Registration
  resources :guild_applications, only: :create

  #Settings
  scope "/user/:username/", as: :user do
    namespace :setting do
      get 'control_panel' => "settings#control_panel", as: :control_panel
      get 'change_password' => "settings#change_password", as: :change_password
      patch 'new_password' => "settings#new_password", as: :new_password

      post 'change_main_character/:id' => "alts#change_main_character", as: :change_main

      resources :alts, except: :show, concerns: :paginatable
      resources :profiles, only: [:edit, :update]
    end
  end

  #Image managment
  namespace :image do
    post '/store/attachment/' => "image_manager#create"
  end

  namespace :flrs do
    resources :events, concerns: :paginatable do
      member do
        post "/sign_up" => "events#sign_up", as: :sign_up
      end
    end
  end
  #Forum
  namespace :forum do
    #Since rails is not perfect it fails to guess correct paths here using 'resources'. Use regular paths with convention action_resource

    #groups
    get '/' => "forum_groups#index", as: :overview
    post '/group/:id/edit' => "forum_groups#edit", as: :edit_group
    put '/group/:id' => "forum_groups#update", as: :update_group
    post '/group' => "forum_groups#create", as: :create_group
    delete '/group/:id' => "forum_groups#delete", as: :delete_group

    #categories
    post '/category/:id/edit' => "forum_category#edit", as: :edit_category
    put '/category/:id' => "forum_category#update", as: :update_category
    post '/category' => "forum_category#create", as: :create_category
    delete '/category/:id' => "forum_category#delete", as: :delete_category

    #threads
    get '/thread' => "forum_threads#new", as: :new_thread
    get '/thread/:id/edit' => "forum_threads#edit", as: :edit_thread
    post '/thread/:id/quote' => "forum_threads#quote", as: :quote_thread
    patch '/thread/:id' => "forum_threads#update", as: :update_thread
    post '/thread' => "forum_threads#create", as: :create_thread
    delete '/thread/:id' => "forum_threads#delete", as: :delete_thread
    patch '/thread/:id/move' => "forum_threads#move", as: :move_thread
    patch '/thread/:id/pin' => "forum_threads#pin", as: :pin_thread
    patch '/thread/:id/copy' => "forum_threads#copy", as: :copy_thread
    patch '/thread/:id/lock' => "forum_threads#lock", as: :lock_thread
    #comments
    get '/comment/:id/edit' => "forum_comments#edit", as: :edit_comment
    post '/comment/:id/quote' => "forum_comments#quote", as: :quote_comment
    put '/comment/:id' => "forum_comments#update", as: :update_comment
    post '/comment' => "forum_comments#create", as: :create_comment
    delete '/comment/:id' => "forum_comments#delete", as: :delete_comment

    #Some scopes for pretty URLS
    scope '/:group/:category' do
      get '/' => "forum_category#show", as: :show_category, concerns: :paginatable
      scope '/:thread/' do
        get '/' => "forum_threads#show", as: :show_thread, concerns: :paginatable
        get '/comment' => "forum_comments#new", as: :new_comment
      end
    end
  end

  #Admin
  namespace :admin do
    get 	'control_panel' => 'pages#control_panel', as: :control_panel
    post 	'toggle_status' => 'guild_applications#toggle_status', as: :guild_application_toggle_status
    post 	'create_user_from_guild_application' => 'users#create_user_from_guild_application', as: :create_user_from_guild_application
    get   'roles/:username' => 'roles#show_roles', as: :user_roles
    patch  'roles/:username' => 'roles#add_role', as: :add_user_role
    delete 'roles/:username' => 'roles#remove_role', as: :remove_user_role
    resources :guild_applications, except: [:new, :create], concerns: :paginatable
    resources :users, concerns: :paginatable
    resources :dungeons, concerns: :paginatable
  end


end
