Rails.application.routes.draw do

  root :to => "pages#index"

  get 'register' => 'guild_applications#new', as: :register
  get 'dashboard' => 'pages#dashboard', as: :dashboard

  resources :guild_applications, only: :create

  namespace :admin do
    get 	'control_panel' => 'pages#control_panel', as: :control_panel
    post 	'toggle_status' => 'guild_applications#toggle_status', as: :guild_application_toggle_status
    post 	'create_user_from_guild_application' => 'users#create_user_from_guild_application', as: :create_user_from_guild_application
    resources :guild_applications, except: [:new, :create]
  end




end
