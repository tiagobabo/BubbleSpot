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
        @lojas = Loja.where("lower(nome) like ? or lower(tags) like ?", search, search).order("nome")         
      elsif params[:pesquisa] == "1"
        search = "%" + params[:query].downcase + "%"
        @lojas = Loja.where("lower(tags) like ? or lower(tags) like ?", search, search).order("nome") 
      end
      
      @lojas = @lojas.order("shopping_id")
      @lojas.each do |loja|
        @shopping = Shopping.find(loja[:shopping_id])
        loja[:shopping_nome] = @shopping.nome 
      end
      @lojas = @lojas.sort_by(&:shopping_nome)
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
        @promos_aux = @loja.promos.ativas.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")  
        @promos_aux.each do |promo|
            promo[:loja_nome] = @loja.nome
            promo[:shopping_id] = @shopping.id
            promo[:shopping_nome] = @shopping.nome
        end
        @promos += @promos_aux
        @promos = @promos.sort_by(&:shopping_nome)
      elsif params[:shopping].present? && params[:shopping] != "-1"
        search = "%" + params[:query].downcase + "%"
        @shopping = Shopping.find(params[:shopping])
        @lojas = @shopping.lojas
        @promos = []
        @promos_aux = []
        @lojas.each do |loja|
          @promos_aux = loja.promos.ativas.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")  
          @promos_aux.each do |promo|
            promo[:loja_nome] = loja.nome
            promo[:shopping_id] = @shopping.id
            promo[:shopping_nome] = @shopping.nome
          end
          @promos += @promos_aux
          @promos = @promos.sort_by(&:shopping_nome)
        end
        
     elsif params[:query].present?
        search = "%" + params[:query].downcase + "%"
        @shoppings = Shopping.all
        @promos = []
        @shoppings.each do |shopping|
          @lojas = shopping.lojas
          @promos_aux = []
          @lojas.each do |loja|
            @promos_aux = loja.promos.ativas.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")  
            @promos_aux.each do |promo|
              promo[:loja_nome] = loja.nome
              promo[:shopping_nome] = shopping.nome
              promo[:shopping_id] = shopping.id
            end
            @promos += @promos_aux
            @promos = @promos.sort_by(&:shopping_nome)
          end
        end
      end
      else
        @shops = [['Todos', -1]]
        @shoppings = Shopping.all
        @shopping = @shopping.sort_by(&:nome)
        @shoppings.each do |shopping|
          @shops += [[shopping.nome, shopping.id]]
        end

        @loj = [['Todas', -1]]
        @lojas = Loja.all
        @lojas = @lojas.sort_by(&:nome)
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
    @lojas = @lojas.sort_by(&:nome)
    options = [-1,'Todas']
    options += @lojas.collect{|x| "#{x.id},#{x.nome}"}
    render :text => "#{options.join(",")}" 
    
  end

  def lojas_by_shopping2
    @shopping = Shopping.find(params[:shopping_id])
    search = "%" + params[:query].downcase + "%"
    @lojas = @shopping.lojas
    @lojas = @lojas.where("lower(nome) like ? or lower(tags) like ?", search, search).order("nome")

    @lojas = @lojas.sort_by(&:nome)
    result = @lojas.collect{|x| "#{x.id},#{x.nome},#{x.imagem},#{x.shopping_id}"}
    render :text => "#{result.join(",")}" 
    
  end

def lojas_by_shopping3
  @lojas = Loja.order("shopping_id, nome")
  search = "%" + params[:query].downcase + "%"
  @lojas = @lojas.where("lower(nome) like ? or lower(tags) like ?", search, search).order("nome") 
  @lojas.each do |loja|
    @shopping = Shopping.find(loja[:shopping_id])
    loja[:shopping_nome] = @shopping.nome 
  end
  @lojas = @lojas.sort_by(&:shopping_nome)

  result = @lojas.collect{|x| "#{x.id},#{x.nome},#{x.imagem},#{x.shopping_id},#{x.shopping_nome}"}
  render :text => "#{result.join(",")}" 
    
  end

def lojas_by_shopping4
    @shopping = Shopping.find(params[:shopping_id])

    @lojas = @shopping.lojas
    @lojas = @lojas.sort_by(&:nome)
    options = []
    options += @lojas.collect{|x| "#{x.id},#{x.nome}"}
    render :text => "#{options.join(",")}" 
    
  end

  def filmes
  @filmes = Filme.order("shopping_id, nome")
  search = "%" + params[:query].downcase + "%"
  @filmes = @filmes.where("lower(nome) like ?", search).order("nome") 
  @filmes.each do |filme|
    @shopping = Shopping.find(filme[:shopping_id])
    filme[:shopping_nome] = @shopping.nome 
  end
  @filmes = @filmes.sort_by(&:shopping_nome)

  result = @filmes.collect{|x| "#{x.id},#{x.nome},#{x.imagem},#{x.shopping_id},#{x.shopping_nome}"}
  render :text => "#{result.join(",")}" 
    
  end

  def promos2
    search = "%" + params[:query].downcase + "%"
  @promos = Promo.ativas.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")
  @promos
  @promos.each do |promo|
    @loja = Loja.find(promo[:loja_id])
    promo[:loja_nome] = @loja.nome
    
    @shopping = Shopping.find(@loja.shopping_id)
    promo[:shopping_nome] = @shopping.nome
    promo[:shopping_id] = @shopping.id
   
  end
  @promos = @promos.sort_by(&:shopping_nome)

  result = @promos.collect{|x| "#{x.id},#{x.produto},#{x.imagem},#{x.shopping_id},#{x.shopping_nome},#{x.desconto},#{x.loja_id}"}
  render :text => "#{result.join(",")}" 
    
  end

  def getLojasPromos
        search = "%" + params[:query].downcase + "%"
        @shopping = Shopping.find(params[:shopping])
        @loja = @shopping.lojas.find(params[:loja])
        @promos = []
        @promos_aux = @loja.promos.ativas.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")  
        @promos_aux.each do |promo|
            promo[:loja_nome] = @loja.nome
            promo[:shopping_id] = @shopping.id
            promo[:shopping_nome] = @shopping.nome
        end
        @promos += @promos_aux
        @promos = @promos.sort_by(&:shopping_nome)

        result = @promos.collect{|x| "#{x.id},#{x.produto},#{x.imagem},#{x.shopping_id},#{x.shopping_nome},#{x.desconto},#{x.loja_id}"}
        render :text => "#{result.join(",")}" 
  end


  def eventos
    search = "%" + params[:query].downcase + "%"
    if params[:p] == "1" or params[:p] == nil
      @p = 1
      @eventos_semana = Evento.where("lower(nome) like ?", search).order("shopping_id, data").where(:data => Time.now.beginning_of_day..Time.now.end_of_week)
      @eventos_semana.each do |evento_semana|
        @shopping = Shopping.find(evento_semana[:shopping_id])
        evento_semana[:shopping_nome] = @shopping.nome 
      end
      @eventos_semana = @eventos_semana.sort_by(&:shopping_nome)
    elsif params[:p] == "2"    
      @p = 2
      @eventos_semana = Evento.where("lower(nome) like ?", search).order("shopping_id, data").where(:data => Time.now.next_week..Time.now.next_week.end_of_week)
      @eventos_semana.each do |evento_semana|
        @shopping = Shopping.find(evento_semana[:shopping_id])
        evento_semana[:shopping_nome] = @shopping.nome  
      end
      @eventos_semana = @eventos_semana.sort_by(&:shopping_nome)
    elsif params[:p] == "3"  
          @p = 3
      @eventos_semana = Evento.where("lower(nome) like ?", search).order("shopping_id, data").where(:data => Time.now.beginning_of_day..Time.now.end_of_month)
      @eventos_semana.each do |evento_semana|
        @shopping = Shopping.find(evento_semana[:shopping_id])
        evento_semana[:shopping_nome] = @shopping.nome  
      end
      @eventos_semana = @eventos_semana.sort_by(&:shopping_nome)
    elsif params[:p] == "4"  
          @p = 4
      @eventos_semana = Evento.where("lower(nome) like ?", search).order("shopping_id, data").where( "data >= date('now')")
      @eventos_semana.each do |evento_semana|
        @shopping = Shopping.find(evento_semana[:shopping_id])
        evento_semana[:shopping_nome] = @shopping.nome  
      end
      @eventos_semana = @eventos_semana.sort_by(&:shopping_nome)
    end

  result = @eventos_semana.collect{|x| "#{x.id},#{x.nome},#{x.imagem},#{x.shopping_id},#{x.shopping_nome}"}
  render :text => "#{result.join(",")}" 

  end

  def allshoppingpromos
    search = "%" + params[:query].downcase + "%"
    @promos = []
    @shopping = Shopping.find(params[:shopping_id])
    @lojas = @shopping.lojas
    @lojas.each do |loja|
      @promos_aux = loja.promos.ativas.where("lower(produto) like ? or lower(detalhes) like ? or lower(tags) like ?", search, search, search).order("produto")
      @promos_aux.each do |promo|
        promo[:loja_nome] = loja.nome
        promo[:shopping_nome] = @shopping.nome
        promo[:shopping_id] = @shopping.id
      end
      @promos += @promos_aux
      @promos = @promos.sort_by(&:shopping_nome)
    end
      
  result = @promos.collect{|x| "#{x.id},#{x.produto},#{x.imagem},#{x.shopping_id},#{x.loja_nome},#{x.desconto},#{x.loja_id}"}
  render :text => "#{result.join(",")}" 

  end


end
