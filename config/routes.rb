Rails.application.routes.draw do

  root :to => "pages#index"
  get 'dashboard' => 'pages#dashboard', as: :dashboard
  
  #session
  get 'register' => 'guild_applications#new', as: :register
  post 'sign_in' => 'sessions#sign_in', as: :sign_in
  get  'sign_out' => 'sessions#sign_out', as: :sign_out
  get  'forgot_password' => "sessions#forgot_password", as: :forgot_password
  post 'send_password_link' => "sessions#send_password_link", as: :send_password_link
  
  resources :guild_applications, only: :create

  namespace :admin do
    get 	'control_panel' => 'pages#control_panel', as: :control_panel
    post 	'toggle_status' => 'guild_applications#toggle_status', as: :guild_application_toggle_status
    post 	'create_user_from_guild_application' => 'users#create_user_from_guild_application', as: :create_user_from_guild_application
    resources :guild_applications, except: [:new, :create]
    resources :users
  end




end
