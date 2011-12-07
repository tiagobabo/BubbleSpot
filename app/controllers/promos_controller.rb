 # -*- coding: utf-8 -*-

class PromosController < ApplicationController
  
  before_filter :require_login
  skip_before_filter :require_login, :only => [:all, :allByShopping, :index, :show]
  
  
  def all
  @promos = Promo.all
  @promos.each do |promo|
    @loja = Loja.find(promo[:loja_id])
    promo[:loja_nome] = @loja.nome
    
    @shopping = Shopping.find(@loja.shopping_id)
    promo[:shopping_nome] = @shopping.nome
    
  end
  respond_to do |format|
    format.html # all.html.erb
    format.json { render :json => @promos }
  end
end
  
  
  def allByShopping
    @promos = []
    @shopping = Shopping.find(params[:shopping_id])
    @lojas = @shopping.lojas
    @lojas.each do |loja|
      @promos_aux = loja.promos
      @promos_aux.each do |promo|
        promo[:loja_nome] = loja.nome
        promo[:shopping_nome] = @shopping.nome
      end
      @promos += @promos_aux
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @promos }
    end
    
  end
  
  # GET /lojas/1/promos
  def index
    # For URL like /lojas/1/promos
    # Get the loja with id=1 
    @shopping = Shopping.find(params[:shopping_id])
    @loja = @shopping.lojas.find(params[:loja_id])

    # Access all promos for that loja
    @promos = @loja.promos
    
    @promos.each do |promo|
      promo[:loja_nome] = @loja.nome
      promo[:shopping_nome] = @shopping.nome
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @promos }
    end
  end

  # GET /lojas/1/promos/2
  def show
    @shopping = Shopping.find(params[:shopping_id])
    @loja = @shopping.lojas.find(params[:loja_id])

    # For URL like /lojas/1/promos/2
    # Find an promo in lojas 1 that has id=2
    @promo = @loja.promos.find(params[:id])

  end

  # GET /lojas/1/promos/new
  def new
    @shopping = Shopping.find(params[:shopping_id])
    @loja = @shopping.lojas.find(params[:loja_id])

    # Associate an promo object with loja 1
    @promo = @loja.promos.build
  end

  # POST /lojas/1/promos
  def create
    @shopping = Shopping.find(params[:shopping_id])
    @loja = @shopping.lojas.find(params[:loja_id])

    # For URL like /lojas/1/promos
    # Populate an promo associate with loja 1 with form data
    # loja will be associated with the promo
    @promo = @loja.promos.build(params[:promo])
    
    respond_to do |format|
    if @promo.save
      # Save the promo successfully
      format.html { redirect_to admins_promos_path(@shopping, @loja), :notice => 'A promoção foi criada com sucesso.' }
    else
      format.html { render :action => "new" }
    end
    end
  end

  # GET /lojas/1/promos/2/edit
  def edit
    @shopping = Shopping.find(params[:shopping_id])
    @loja = @shopping.lojas.find(params[:loja_id])

    # For URL like /lojas/1/promos/2/edit
    # Get promo id=2 for loja 1
    @promo = @loja.promos.find(params[:id])
  end

  # PUT /lojas/1/promos/2
  def update
    @shopping = Shopping.find(params[:shopping_id])
    @loja = @shopping.lojas.find(params[:loja_id])
    @promo = Promo.find(params[:id])
    
    respond_to do |format|
    if @promo.update_attributes(params[:promo])
      # Save the promo successfully
      format.html { redirect_to admins_promos_path(@shopping, @loja), :notice => 'A promoção foi atualizada com sucesso.' }
    else
       format.html {render :action => "edit" }
    end
    end
  end

  # DELETE /lojas/1/promos/2
  def destroy
    @shopping = Shopping.find(params[:shopping_id])
    @loja = @shopping.lojas.find(params[:loja_id])
    @promo = Promo.find(params[:id])
    @promo.destroy

    respond_to do |format|
      format.html { redirect_to admins_promos_path(@shopping, @loja), :notice => 'A promoção foi eliminada com sucesso.' }
      format.xml  { head :ok }
    end
  end

end
