 # -*- coding: utf-8 -*-

class SearchController < ApplicationController

  TERMOS = [['Nome',0], ['Localização',1], ['Email',2]]
  
  def shoppings   
    
    
    if params[:query].present?
      
      if params[:pesquisa] == "0"
        search = params[:query].downcase + "%"
        @shoppings = Shopping.where("nome like ?", search)        
      elsif params[:pesquisa] == "1"
        search = "%" + params[:query].downcase + "%"
        @shoppings = Shopping.where("localizacao like ?", search)
      elsif params[:pesquisa] == "2"
        search = "%" + params[:query].downcase + "%"
        @shoppings = Shopping.where("email like ?", search)   
      
      end
  
      respond_to do |format|
        format.html # shoppings.html.erb
        format.json { render :json => @shoppings }
      end
  
    elsif params[:latitude].present? && params[:longitude].present?
      coordenadas = [Float(params[:latitude]), Float(params[:longitude])]
      @shoppings = Shopping.near(coordenadas, Geocoder::Calculations::to_miles(20), :order => :distance)
      respond_to do |format|
        format.json { render :json => @shoppings }
      end
    else
      render "shoppings_index"
    end
  end
  
end
