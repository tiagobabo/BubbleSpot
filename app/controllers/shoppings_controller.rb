 # -*- coding: utf-8 -*-

class ShoppingsController < ApplicationController
  # GET /shoppings
  # GET /shoppings.json
  
  before_filter :only => [:create, :new, :destroy] do |controller| require_login(0) end
  before_filter :only => [:edit] do |controller| require_login(1, params[:id]) end
  
  set_tab :shopping

  def index
    
    @shoppings = Shopping.order("nome")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @shoppings }
    end
  end

  # GET /shoppings/1
  # GET /shoppings/1.json
  def show
     @promos = []
      @shopping = Shopping.find(params[:id])
    @lojas = @shopping.lojas
    @lojas.each do |loja|
      @promos_aux = loja.promos.order("produto")
      @promos_aux.each do |promo|
        promo[:loja_nome] = loja.nome
        promo[:shopping_nome] = @shopping.nome
        promo[:shopping_id] = @shopping.id
      end
      @promos += @promos_aux
    end
     @new_promos =   @promos.sort_by(&:created_at)[0..2]
     @last_promos =  @promos.sort_by(&:created_at)[0..2]
     @last_promos -= @new_promos
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @shopping }
    end
  end
  
  # GET /shoppings/new
  # GET /shoppings/new.json
  def new  
    
      @shopping = Shopping.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @shopping }
      end
      
  end

  # GET /shoppings/1/edit
  def edit
      @shopping = Shopping.find(params[:id])
  end

  # POST /shoppings
  # POST /shoppings.json
  def create
    @shopping = Shopping.new(params[:shopping])

    respond_to do |format|
      if @shopping.save
        format.html { redirect_to admins_shoppings_url, :notice => 'O Shopping foi criado com sucesso.' }
        format.json { render :json => @shopping, :status => :created, :location => @shopping }
      else
        format.html { render :action => "new" }
        format.json { render :json => @shopping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shoppings/1
  # PUT /shoppings/1.json
  def update
    
    @shopping = Shopping.find(params[:id])

    respond_to do |format|
      if @shopping.update_attributes(params[:shopping])
        format.html { redirect_to admins_shoppings_url , :notice => 'O Shopping foi actualizado com sucesso.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @shopping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shoppings/1
  # DELETE /shoppings/1.json
  def destroy
      @shopping = Shopping.find(params[:id])
      @shopping.destroy

      respond_to do |format|
        format.html { redirect_to admins_shoppings_url , :notice => 'O Shopping foi eliminado com sucesso.' }
        format.json { head :ok }
      end
    end
end
