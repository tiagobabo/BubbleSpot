 # -*- coding: utf-8 -*-

class SearchController < ApplicationController

  TERMOS = [['Nome',0], ['Localização',1]]
  TERMOS_LOJAS = [['Nome',0], ['Áreas de negócio',1]]

  set_tab :pesquisa
  
  def index
    @shops = [['Todos', -1]]
    @shoppings = Shopping.order("nome")
    @shoppings.each do |shopping|
      @shops += [[shopping.nome, shopping.id]]
    end

    @loj = [['Todas', -1]]
    @lojas = Loja.all
    @lojas.each do |loja|
      @loj += [[loja.nome, loja.id]]
    end
  end
  
  def shoppings   
    
    if params[:query].present?
      
      if params[:pesquisa] == "0"
        search = "%" + params[:query].downcase + "%"
        @shoppings = Shopping.where("lower(nome) like ?", search).order("nome")        
      elsif params[:pesquisa] == "1"
        search = "%" + params[:query].downcase + "%"
        @shoppings = Shopping.where("lower(localizacao) like ?", search).order("nome") 
    
      end
  
      respond_to do |format|
        format.html # shoppings.html.erb
        format.json { render :json => @shoppings }
      end
  
    elsif params[:latitude].present? && params[:longitude].present? && params[:radius].present?
      coordenadas = [Float(params[:latitude]), Float(params[:longitude])]
      @shoppings = Shopping.near(coordenadas, Geocoder::Calculations::to_miles(Integer(params[:radius])), :order => :distance)
      respond_to do |format|
        format.json { render :json => @shoppings }
      end
    else
      render "shoppings_index"
    end
  end
  
  def lojas 
    
     if params[:query].present?
      
      if params[:pesquisa] == "0"
        search = "%" + params[:query].downcase + "%"
        @lojas = Loja.where("lower(nome) like ?", search).order("nome")         
      elsif params[:pesquisa] == "1"
        search = "%" + params[:query].downcase + "%"
        @lojas = Loja.where("lower(tags) like ?", search).order("nome") 
      end
      
      @lojas = @lojas.order("shopping_id")
      @lojas.each do |loja|
        @shopping = Shopping.find(loja[:shopping_id])
        loja[:shopping_nome] = @shopping.nome 
      end
    respond_to do |format|
        format.html # lojas.html.erb
        format.json { render :json => @lojas }
      end
    else 
      render "lojas_index"
    end
    
  end
  
   def promos
      
      if params[:query].present?
      if params[:loja].present? && params[:loja] != "-1"
        search = "%" + params[:query].downcase + "%"
        @shopping = Shopping.find(params[:shopping])
        @loja = @shopping.lojas.find(params[:loja])
        @promos = []
        @promos_aux = @loja.promos.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")  
        @promos_aux.each do |promo|
            promo[:loja_nome] = @loja.nome
            promo[:shopping_id] = @shopping.id
            promo[:shopping_nome] = @shopping.nome
        end
        @promos += @promos_aux
      elsif params[:shopping].present? && params[:shopping] != "-1"
        search = "%" + params[:query].downcase + "%"
        @shopping = Shopping.find(params[:shopping])
        @lojas = @shopping.lojas
        @promos = []
        @promos_aux = []
        @lojas.each do |loja|
          @promos_aux = loja.promos.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")  
          @promos_aux.each do |promo|
            promo[:loja_nome] = loja.nome
            promo[:shopping_id] = @shopping.id
            promo[:shopping_nome] = @shopping.nome
          end
          @promos += @promos_aux
        end
        
     elsif params[:query].present?
        search = "%" + params[:query].downcase + "%"
        @shoppings = Shopping.all
        @promos = []
        @shoppings.each do |shopping|
          @lojas = shopping.lojas
          @promos_aux = []
          @lojas.each do |loja|
            @promos_aux = loja.promos.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")  
            @promos_aux.each do |promo|
              promo[:loja_nome] = loja.nome
              promo[:shopping_nome] = shopping.nome
              promo[:shopping_id] = shopping.id
            end
            @promos += @promos_aux
          end
        end
      end
      else
        @shops = [['Todos', -1]]
        @shoppings = Shopping.all
        @shoppings.each do |shopping|
          @shops += [[shopping.nome, shopping.id]]
        end

        @loj = [['Todas', -1]]
        @lojas = Loja.all
        @lojas.each do |loja|
          @loj += [[loja.nome, loja.id]]
        end
    end
    respond_to do |format|
      if params[:query].present?
        format.html
        format.json { render :json => @promos }
      else
        format.html {render "promos_index"}
      end  
    end
  end
  
  def lojas_by_shopping
    @shopping = Shopping.find(params[:shopping_id])
    @lojas = @shopping.lojas
    options = [-1,'Todas']
    options += @lojas.collect{|x| "#{x.id},#{x.nome}"}
    render :text => "#{options.join(",")}" 
    
  end

  def lojas_by_shopping2
    @shopping = Shopping.find(params[:shopping_id])
    search = "%" + params[:query].downcase + "%"
    @lojas = @shopping.lojas
    @lojas = @lojas.where("lower(nome) like ?", search).order("nome")

    result = @lojas.collect{|x| "#{x.id},#{x.nome},#{x.imagem},#{x.shopping_id}"}
    render :text => "#{result.join(",")}" 
    
  end

def lojas_by_shopping3
  @lojas = Loja.order("shopping_id, nome")
  search = "%" + params[:query].downcase + "%"
  @lojas = @lojas.where("lower(nome) like ?", search).order("nome") 
  @lojas.each do |loja|
    @shopping = Shopping.find(loja[:shopping_id])
    loja[:shopping_nome] = @shopping.nome 
  end

  result = @lojas.collect{|x| "#{x.id},#{x.nome},#{x.imagem},#{x.shopping_id},#{x.shopping_nome}"}
  render :text => "#{result.join(",")}" 
    
  end

  def filmes
  @filmes = Filme.order("shopping_id, nome")
  search = "%" + params[:query].downcase + "%"
  @filmes = @filmes.where("lower(nome) like ?", search).order("nome") 
  @filmes.each do |filme|
    @shopping = Shopping.find(filme[:shopping_id])
    filme[:shopping_nome] = @shopping.nome 
  end

  result = @filmes.collect{|x| "#{x.id},#{x.nome},#{x.imagem},#{x.shopping_id},#{x.shopping_nome}"}
  render :text => "#{result.join(",")}" 
    
  end

  def promos2
    search = "%" + params[:query].downcase + "%"
  @promos = Promo.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")
  @promos
  @promos.each do |promo|
    @loja = Loja.find(promo[:loja_id])
    promo[:loja_nome] = @loja.nome
    
    @shopping = Shopping.find(@loja.shopping_id)
    promo[:shopping_nome] = @shopping.nome
    promo[:shopping_id] = @shopping.id
   
  end
  @promos = @promos.sort_by(&:shopping_id)

  result = @promos.collect{|x| "#{x.id},#{x.produto},#{x.imagem},#{x.shopping_id},#{x.shopping_nome}"}
  render :text => "#{result.join(",")}" 
    
  end

end
