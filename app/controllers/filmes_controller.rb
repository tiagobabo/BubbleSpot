 # -*- coding: utf-8 -*-

class FilmesController < ApplicationController
  
  before_filter :except => [:all, :index, :show] do |controller| require_login(1, params[:shopping_id]) end

  set_tab :filme

def all
  @filmes = Filme.order("shopping_id,nome")
  @filmes.each do |filme|
    @shopping = Shopping.find(filme[:shopping_id])
    filme[:shopping_nome] = @shopping.nome 
  end
  @filmes = @filmes.sort_by(&:shopping_nome)
  respond_to do |format|
    format.html #all.html.erb
    format.json { render :json => @filmes }
  end
end

# GET /shoppings/1/filmes
  def index
    # For URL like /shoppings/1/filmes
    # Get the shopping with id=1
    @shopping = Shopping.find(params[:id])

    # Access all filmes for that shopping
    @filmes = @shopping.filmes.order("nome").paginate(:per_page => 10, :page => params[:page])
    
    @filmes.each do |filme|
     filme[:shopping_nome] = @shopping.nome
  end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @filmes }
    end
  end

  # GET /shoppings/1/filmes/2
  def show
    @shopping = Shopping.find(params[:shopping_id])

    # For URL like /shoppings/1/filmes/2
    # Find an filme in shoppings 1 that has id=2
    @filme = @shopping.filmes.find(params[:id])
    @filme[:shopping_nome] = @shopping.nome
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @filme }
    end
  end

  # GET /shoppings/1/filmes/new
  def new
    set_tab :filme_new
    @shopping = Shopping.find(params[:shopping_id])

    # Associate an filme object with shopping 1
    @filme = @shopping.filmes.build
    
  end

  # POST /shoppings/1/filmes
  def create
    @shopping = Shopping.find(params[:shopping_id])

    # For URL like /shoppings/1/filmes
    # Populate an filme associate with shopping 1 with form data
    # Shopping will be associated with the filme
    @filme = @shopping.filmes.build(params[:filme])
    respond_to do |format|
      if @filme.save
        # Save the filme successfully
        format.html { redirect_to admins_filmes_url(@shopping) , :notice => 'O filme foi criada com sucesso.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # GET /shoppings/1/filmes/2/edit
  def edit
    set_tab :filme_edit
    @shopping = Shopping.find(params[:shopping_id])

    # For URL like /shoppings/1/filmes/2/edit
    # Get filme id=2 for shopping 1
    @filme = @shopping.filmes.find(params[:id])
  end

  # PUT /shoppings/1/filmes/2
  def update
    @shopping = Shopping.find(params[:shopping_id])
    @filme = Filme.find(params[:id])
    
    
    respond_to do |format|
      if @filme.update_attributes(params[:filme])
        # Save the filme successfully
        format.html { redirect_to admins_filmes_url(@shopping) , :notice => 'O filme foi atualizada com sucesso.' }
      else
        format.html {render :action => "edit" }
      end
    end
  end

  # DELETE /shoppings/1/filmes/2
  def destroy
    @shopping = Shopping.find(params[:shopping_id])
    @filme = Filme.find(params[:id])
    @filme.destroy

    respond_to do |format|
      format.html { redirect_to admins_filmes_url(@shopping) , :notice => 'O filme foi eliminada com sucesso.' }
      format.xml  { head :ok }
    end
  end

end
