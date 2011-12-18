BubbleSpot::Application.routes.draw do

  get "admin/log_out" => "sessions#destroy", :as => "log_out"
  get "admin/log_in" => "sessions#new", :as => "log_in"
  get "admin" => "sessions#new"
  get "admin/sign_up" => "admins#new", :as => "sign_up"
  get "admin/index" => "admins#index", :as => "admins_index"
  get "admin/shoppings" => "admins#shoppings", :as => "admins_shoppings"
  get "admin/shoppings/new" => "shoppings#new", :as => "new_shopping"
  get "admin/shoppings/edit/:id" => "shoppings#edit", :as => "edit_shopping"
  
  get "admin/utilizadores/edit/:admin" => "admins#edit",  :as => "edit_admin"
  delete "admin/utilizadores/destroy/:admin" => "admins#destroy",  :as => "destroy_admin"
  put "admin/utilizadores/save/:admin_id" => "admins#update", :as => "update_admin"

  get "admin/shoppings/:id/lojas" => "admins#lojas", :as => "admins_lojas"
  get "admin/shoppings/:shopping_id/lojas/new" => "lojas#new", :as => "new_loja"
  get "admin/shoppings/:shopping_id/lojas/:id/edit" => "lojas#edit", :as => "edit_loja"
  get "admin/shoppings/:shopping_id/lojas/:loja_id/promos/:id/edit" => "promos#edit", :as => "edit_promo"
  get "admin/shoppings/:shopping_id/lojas/:loja_id/promos" => "admins#promos", :as => "admins_promos"
  get "admin/utilizadores" => "admins#users", :as => "admins_users"

  get "search/shoppings/" => "search#shoppings", :as => "search_shoppings"  
  get "search/lojas/" => "search#lojas", :as => "search_lojas"
  get "search/promos/" => "search#promos", :as => "search_promos"  
  get "search/lojas_by_shopping/" => "search#lojas_by_shopping", :as => "lojas_by_shopping"  
  get "search/lojas_by_shopping2/" => "search#lojas_by_shopping2", :as => "lojas_by_shopping2"  
  get "search/lojas_by_shopping3/" => "search#lojas_by_shopping3", :as => "lojas_by_shopping3"  
    get "search/lojas_by_shopping4/" => "search#lojas_by_shopping4", :as => "lojas_by_shopping4"  
  get "search/filmes/" => "search#filmes", :as => "search_filmes"  
  get "search/eventos/" => "search#eventos", :as => "search_eventos"  
  get "search/promos2/" => "search#promos2", :as => "search_promos2"
  get "search/getLojasPromos/" => "search#getLojasPromos", :as => "search_getLojasPromos"
  get "search/allshoppingpromos/" => "search#allshoppingpromos", :as => "allshoppingpromos"
  get "search" => "search#index", :as => "search"  
  get "shoppings/:id/lojas" => "lojas#index", :as => "lojas_shopping_index"



  get "shoppings/:shopping_id/promos" => "promos#allByShopping", :as => "promos_shopping_index"

  get "lojas" => "lojas#all", :as => "lojas_all"
  get "promos" => "promos#all", :as => "promos_all"
  get "filmes" => "filmes#all", :as => "filmes_all"
  get "eventos" => "eventos#all", :as => "eventos_all"
 
  
  get "shoppings/:id/filmes" => "filmes#index", :as => "filmes_shopping_index"
  get "admin/shoppings/:id/filmes" => "admins#filmes", :as => "admins_filmes"
  get "admin/shoppings/:shopping_id/filmes/new" => "filmes#new", :as => "new_filme"
  get "admin/shoppings/:shopping_id/filmes/edit/:id" => "filmes#edit", :as => "edit_filme"
  
  get "shoppings/:id/eventos" => "eventos#index", :as => "eventos_shopping_index"
  get "admin/shoppings/:id/eventos" => "admins#eventos", :as => "admins_eventos"
  get "admin/shoppings/:shopping_id/eventos/new" => "eventos#new", :as => "new_evento"
  get "admin/shoppings/:shopping_id/eventos/edit/:id" => "eventos#edit", :as => "edit_evento"

  get "contactos" => "application#contactos", :as => "contactos"

  root :to => "application#home" 
  
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
