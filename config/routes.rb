BubbleSpot::Application.routes.draw do

  get "admin/log_out" => "sessions#destroy", :as => "log_out"
  get "admin/log_in" => "sessions#new", :as => "log_in"
  get "admin" => "sessions#new"
  get "admin/sign_up" => "admins#new", :as => "sign_up"
  get "admin/index" => "admins#index", :as => "admins_index"
  get "admin/shoppings" => "admins#shoppings", :as => "admins_shoppings"
  get "search/shoppings/:query" => "search#shoppings", :as => "search_shoppings" 
  get "search/shoppings/" => "search#shoppings", :as => "search_shoppings"  
  get "admin/shoppings/new" => "shoppings#new", :as => "new_shopping"
  get "admin/shoppings/edit/:id" => "shoppings#edit", :as => "edit_shopping"
  
  
  root :to => "shoppings#index" 
  
  resources :admins
  resources :sessions
  resources :search
  resources :shoppings

 
end
