class SearchController < ApplicationController
  
  def shoppings   
    if params[:query]
      search = params[:query] + "%"
      @shoppings = Shopping.where("nome like ?", search)
      
      respond_to do |format|
        format.html # shoppings.html.erb
        format.json { render :json => @shoppings }
      end
      
    else
      render "shoppings_index"
    end
  end
  
end
