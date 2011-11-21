BubbleSpot::Application.routes.draw do

  get "lojas/index"

  get "lojas/show"

  get "lojas/new"

  get "lojas/edit"

  get "admin/log_out" => "sessions#destroy", :as => "log_out"
  get "admin/log_in" => "sessions#new", :as => "log_in"
  get "admin" => "sessions#new"
  get "admin/sign_up" => "admins#new", :as => "sign_up"
  get "admin/index" => "admins#index", :as => "admins_index"
  get "admin/shoppings" => "admins#shoppings", :as => "admins_shoppings"
  get "search/shoppings/" => "search#shoppings", :as => "search_shoppings"  
  get "search/lojas/" => "search#lojas", :as => "search_lojas"  
  get "admin/shoppings/new" => "shoppings#new", :as => "new_shopping"
  get "admin/shoppings/edit/:id" => "shoppings#edit", :as => "edit_shopping"
  get "admin/news" => "shoppings#new"
  get "shoppings/:id/lojas" => "lojas#index", :as => "lojas_shopping_index"
  get "admin/shoppings/:id/lojas" => "admins#lojas", :as => "admins_lojas"


  
  
  root :to => "shoppings#index" 
  
  resources :admins
  resources :sessions
  resources :search
  
  resources :shoppings do
    resources :lojas
  end
  

 
end
