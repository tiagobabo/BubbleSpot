class LojasController < ApplicationController
 

# GET /lojas.json

def all
  @lojas = Loja.all
  respond_to do |format|
    format.json { render :json => @lojas }
  end
end

# GET /shoppings/1/lojas
  def index
    # For URL like /shoppings/1/lojas
    # Get the shopping with id=1
    @shopping = Shopping.find(params[:id])

    # Access all lojas for that shopping
    @lojas = @shopping.lojas
    @loja[:shopping_nome] = @shopping.nome
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
    @loja[:shopping_nome] = @shopping.nome
    
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
    respond_to do |format|
      if @loja.save
        # Save the loja successfully
        format.html { redirect_to admins_lojas_url(@shopping) , :notice => 'A loja foi criada com sucesso.' }
      else
        format.html { render :action => "new" }
      end
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
    
    
    respond_to do |format|
      if @loja.update_attributes(params[:loja])
        # Save the loja successfully
        format.html { redirect_to admins_lojas_url(@shopping) , :notice => 'A loja foi atualizada com sucesso.' }
      else
        format.html {render :action => "edit" }
      end
    end
  end

  # DELETE /shoppings/1/lojas/2
  def destroy
    @shopping = Shopping.find(params[:shopping_id])
    @loja = Loja.find(params[:id])
    @loja.destroy

    respond_to do |format|
      format.html { redirect_to admins_lojas_url(@shopping) , :notice => 'A loja foi eliminada com sucesso.' }
      format.xml  { head :ok }
    end
  end

end
