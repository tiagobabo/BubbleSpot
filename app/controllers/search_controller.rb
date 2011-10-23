class SearchController < ApplicationController
  
  def shoppings   
    if params[:query]
      search = params[:query] + "%"
      @shoppings = Shopping.where("nome like ?", search)
    else
      render "shoppings_index"
    end
  end
  
end
