class SearchController < ApplicationController

  TERMOS = [['Nome',0], ['Localização',1], ['Email',2]]
  
  def shoppings   
    
    
    if params[:query]
      
      if params[:pesquisa] == "0"
        search = params[:query].downcase + "%"
        @shoppings = Shopping.where("nome like ?", search)        
      elsif params[:pesquisa] == "1"
        search = params[:query].downcase + "%"
        @shoppings = Shopping.where("localizacao like ?", search)
      elsif params[:pesquisa] == "2"
        search = params[:query].downcase + "%"
        @shoppings = Shopping.where("email like ?", search)        
      end
  
      respond_to do |format|
        format.html # shoppings.html.erb
        format.json { render :json => @shoppings }
      end
  
    else
      render "shoppings_index"
    end
  end
  
end
