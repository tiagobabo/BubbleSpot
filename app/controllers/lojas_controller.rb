class LojasController < ApplicationController
 
# GET /shoppings/1/lojas
  def index
    # For URL like /shoppings/1/lojas
    # Get the shopping with id=1
    @shopping = Shopping.find(params[:id])

    # Access all lojas for that shopping
    @lojas = @shopping.lojas
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @lojas }
    end
  end

  # GET /shoppings/1/lojas/2
  def show
    @shopping = Shopping.find(params[:shopping_id])

    # For URL like /shoppings/1/lojas/2
    # Find an loja in shoppings 1 that has id=2
    @loja = @shopping.lojas.find(params[:id])
     respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @loja }
    end
  end

  # GET /shoppings/1/lojas/new
  def new
    @shopping = Shopping.find(params[:shopping_id])

    # Associate an loja object with shopping 1
    @loja = @shopping.lojas.build
    
  end

  # POST /shoppings/1/lojas
  def create
    @shopping = Shopping.find(params[:shopping_id])

    # For URL like /shoppings/1/lojas
    # Populate an loja associate with shopping 1 with form data
    # Shopping will be associated with the loja
    @loja = @shopping.lojas.build(params[:loja])
    if @loja.save
      # Save the loja successfully
      redirect_to shopping_loja_url(@shopping, @loja)
    else
      render :action => "new"
    end
  end

  # GET /shoppings/1/lojas/2/edit
  def edit
    @shopping = Shopping.find(params[:shopping_id])

    # For URL like /shoppings/1/lojas/2/edit
    # Get loja id=2 for shopping 1
    @loja = @shopping.lojas.find(params[:id])
  end

  # PUT /shoppings/1/lojas/2
  def update
    @shopping = Shopping.find(params[:shopping_id])
    @loja = Loja.find(params[:id])
    if @loja.update_attributes(params[:loja])
      # Save the loja successfully
      redirect_to shopping_loja_url(@shopping, @loja)
    else
      render :action => "edit"
    end
  end

  # DELETE /shoppings/1/lojas/2
  def destroy
    @shopping = Shopping.find(params[:shopping_id])
    @loja = Loja.find(params[:id])
    @loja.destroy

    respond_to do |format|
      format.html { redirect_to shopping_lojas_path(@shopping) }
      format.xml  { head :ok }
    end
  end

end
