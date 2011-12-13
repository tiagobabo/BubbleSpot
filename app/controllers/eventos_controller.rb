class EventosController < ApplicationController
  # GET /eventos.json

  before_filter :except => [:all, :index, :show] do |controller| require_login(1, params[:shopping_id]) end

  set_tab :evento

  def all
    @eventos = Evento.order("data, shopping_id")
    @eventos.each do |evento|
      @shopping = Shopping.find(evento[:shopping_id])
      evento[:shopping_nome] = @shopping.nome 
    end
    respond_to do |format|
      format.html #all.html.erb
      format.json { render :json => @eventos }
    end
  end

# GET /shoppings/1/eventos
  def index
    # For URL like /shoppings/1/eventos
    # Get the shopping with id=1
    @shopping = Shopping.find(params[:id])

    # Access all eventos for that shopping

    @eventos = @shopping.eventos.order("data ASC").paginate(:per_page => 10, :page => params[:page])
    
    @eventos.each do |evento|
     evento[:shopping_nome] = @shopping.nome
  end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @eventos }
    end
  end

  # GET /shoppings/1/eventos/2
  def show
    @shopping = Shopping.find(params[:shopping_id])

    # For URL like /shoppings/1/eventos/2
    # Find an evento in shoppings 1 that has id=2
    @evento = @shopping.eventos.find(params[:id])
    @evento[:shopping_nome] = @shopping.nome
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @evento }
    end
  end

  # GET /shoppings/1/eventos/new
  def new
    @shopping = Shopping.find(params[:shopping_id])

    # Associate an evento object with shopping 1
    @evento = @shopping.eventos.build
    
  end

  # POST /shoppings/1/eventos
  def create
    @shopping = Shopping.find(params[:shopping_id])

    # For URL like /shoppings/1/eventos
    # Populate an evento associate with shopping 1 with form data
    # Shopping will be associated with the evento
    @evento = @shopping.eventos.build(params[:evento])
    respond_to do |format|
      if @evento.save
        # Save the evento successfully
        format.html { redirect_to admins_eventos_url(@shopping) , :notice => 'O evento foi criado com sucesso.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # GET /shoppings/1/eventos/2/edit
  def edit
    @shopping = Shopping.find(params[:shopping_id])

    # For URL like /shoppings/1/eventos/2/edit
    # Get evento id=2 for shopping 1
    @evento = @shopping.eventos.find(params[:id])
  end

  # PUT /shoppings/1/eventos/2
  def update
    @shopping = Shopping.find(params[:shopping_id])
    @evento = @shopping.eventos.find(params[:id])
    
    
    respond_to do |format|
      if @evento.update_attributes(params[:evento])
        # Save the evento successfully
        format.html { redirect_to admins_eventos_url(@shopping) , :notice => 'O evento foi atualizado com sucesso.' }
      else
        format.html {render :action => "edit" }
      end
    end
  end

  # DELETE /shoppings/1/eventos/2
  def destroy
    @shopping = Shopping.find(params[:shopping_id])
    @evento = @shopping.eventos.find(params[:id])
    @evento.destroy

    respond_to do |format|
      format.html { redirect_to admins_eventos_url(@shopping) , :notice => 'O evento foi eliminado com sucesso.' }
      format.xml  { head :ok }
    end
  end


end
