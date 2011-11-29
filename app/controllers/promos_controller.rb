class PromosController < ApplicationController
  
  before_filter :require_login
  skip_before_filter :require_login, :only => [:allByShopping, :index, :show]
  
  
  
  def allByShopping
    @promos = []
    @shopping = Shopping.find(params[:shopping_id])
    @lojas = @shopping.lojas
    @lojas.each do |loja|
      @promos += loja.promos
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
    if @promo.save
      # Save the promo successfully
      redirect_to shopping_loja_promo_url(@shopping, @loja, @promo)
    else
      render :action => "new"
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
    if @promo.update_attributes(params[:promo])
      # Save the promo successfully
      redirect_to shopping_loja_promo_url(@shopping, @loja, @promo)
    else
      render :action => "edit"
    end
  end

  # DELETE /lojas/1/promos/2
  def destroy
    @shopping = Shopping.find(params[:shopping_id])
    @loja = @shopping.lojas.find(params[:loja_id])
    @promo = Promo.find(params[:id])
    @promo.destroy

    respond_to do |format|
      format.html { redirect_to shopping_loja_promos_path(@shopping, @loja) }
      format.xml  { head :ok }
    end
  end

end