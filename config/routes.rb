BubbleSpot::Application.routes.draw do

  get "admin/log_out" => "sessions#destroy", :as => "log_out"
  get "admin/log_in" => "sessions#new", :as => "log_in"
  
  get "shoppings/index" => "shoppings#index", :as => "shoppings_index"
  
  get "admin" => "sessions#new"
  
  get "admin/sign_up" => "admins#new", :as => "sign_up"
  
  get "admin/index" => "admins#index", :as => "admins_index"
  
  root :to => "shoppings#index" 
  
  resources :admins
  resources :sessions
  
  # resources :sessions

  resources :shoppings

 
end
