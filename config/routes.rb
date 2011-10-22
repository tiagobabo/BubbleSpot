BubbleSpot::Application.routes.draw do

  get "admin/log_out" => "sessions#destroy", :as => "log_out"
  get "admin/log_in" => "sessions#new", :as => "log_in"
  
  # get "admin/sign_up" => "admins#new", :as => "sign_up"
  root :to => "shoppings#index" 
  
  resources :admins
  resources :sessions
  
  # resources :sessions

  resources :shoppings

 
end
