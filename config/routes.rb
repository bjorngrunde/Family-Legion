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
  #Forum
  namespace :forum do
    get   "/" => "forum_groups#index", as: :index
    post  "create/group" => "forum_groups#create", as: :create_group
    post  "edit/group/:id" => "forum_groups#edit", as: :edit_group
    put   "update/group/:id" => "forum_groups#update", as: :update_group
    get   "category/:id" => "forum_categories#show", as: :category_show, concerns: :paginatable
    post  "create/category" => "forum_categories#create", as: :create_category
    post  "edit/category/:id" => "forum_categories#edit", as: :edit_category
    put   "update/category/:id" => "forum_categories#update", as: :update_category
    get   "category/:forum_category_id/create_thread" => "forum_threads#new", as: :new_thread
    post  "category/:forum_category_id/create_thread" => "forum_threads#create", as: :create_thread
    get   "category/:forum_category_id/thread/:url" => "forum_threads#show", as: :show_thread
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
  end


end
