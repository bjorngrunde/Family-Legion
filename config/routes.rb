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
    get '/' => "forum_groups#index", as: :overview
    resources :forum_groups, except: [:show, :index], as: :group
    scope '/:group/' do
      scope '/:category/' do
        get '/' => "forum_categories#show", as: :category_show
        resources :forum_category, except: [:show, :index], as: :category

        scope '/:thread/' do
          get '/' => "forum_threads#show", as: :thread_show
          resources :forum_threads, except: :show, concerns: :paginatable
        end
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
  end


end
