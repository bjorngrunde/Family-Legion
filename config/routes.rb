Rails.application.routes.draw do

  root :to => "pages#index"

  get 'register' => 'guild_applications#new', as: :register
  get 'dashboard' => 'pages#dashboard', as: :dashboard

  resources :guild_applications, only: :create

  namespace :admin do
    get 'control_panel' => 'pages#control_panel', as: :control_panel
    resources :guild_applications, except: [:new, :create]
  end




end
