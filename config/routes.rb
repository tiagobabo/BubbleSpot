BubbleSpot::Application.routes.draw do

  get "admin/log_out" => "sessions#destroy", :as => "log_out"
  get "admin/log_in" => "sessions#new", :as => "log_in"
  get "admin" => "sessions#new"
  get "admin/sign_up" => "admins#new", :as => "sign_up"
  get "admin/index" => "admins#index", :as => "admins_index"
  get "admin/shoppings" => "admins#shoppings", :as => "admins_shoppings"
  get "admin/shoppings/new" => "shoppings#new", :as => "new_shopping"
  get "admin/shoppings/edit/:id" => "shoppings#edit", :as => "edit_shopping"
  get "admin/news" => "shoppings#new"
  get "admin/shoppings/:id/lojas" => "admins#lojas", :as => "admins_lojas"
  get "admin/shoppings/:shopping_id/lojas/new" => "lojas#new", :as => "new_loja"
  get "admin/shoppings/:shopping_id/lojas/edit/:id" => "lojas#edit", :as => "edit_loja"
  get "admin/shoppings/:shopping_id/lojas/:lojas_id/promos" => "admins#promos", :as => "admins_promos"
  
  get "search/shoppings/" => "search#shoppings", :as => "search_shoppings"  
  get "search/lojas/" => "search#lojas", :as => "search_lojas"
  get "search/promos/" => "search#promos", :as => "search_promos"  
  get "search/lojas_by_shopping/" => "search#lojas_by_shopping", :as => "lojas_by_shopping"  
  
  get "shoppings/:id/lojas" => "lojas#index", :as => "lojas_shopping_index"
  
  get "lojas" => "lojas#all", :as => "lojas_all"
  get "promos" => "promos#all", :as => "promos_all"
  get "shoppings/:shopping_id/promos" => "promos#allByShopping"
 
  
  get "shoppings/:id/filmes" => "filmes#index", :as => "filmes_shopping_index"
  get "admin/shoppings/:id/filmes" => "admins#filmes", :as => "admins_filmes"
  get "admin/shoppings/:shopping_id/filmes/new" => "filmes#new", :as => "new_filme"
  get "admin/shoppings/:shopping_id/filmes/edit/:id" => "filmes#edit", :as => "edit_filme"
  
  get "shoppings/:id/eventos" => "eventos#index", :as => "eventos_shopping_index"
  get "admin/shoppings/:id/eventos" => "admins#eventos", :as => "admins_eventos"
  get "admin/shoppings/:shopping_id/eventos/new" => "eventos#new", :as => "new_evento"
  get "admin/shoppings/:shopping_id/eventos/edit/:id" => "eventos#edit", :as => "edit_evento"

  root :to => "shoppings#index" 
  
  resources :admins
  resources :sessions
  resources :search
  
  resources :shoppings do
    resources :filmes
    resources :eventos
    resources :lojas do
      resources :promos
    end
  end
  
  resources :lojas do
      resources :promos
    end
 
end
