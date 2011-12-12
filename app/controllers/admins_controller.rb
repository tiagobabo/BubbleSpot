class AdminsController < ApplicationController
  
  #before_filter :require_login
  #este before_filter acaba por não ser necessário(?)
  #visto que no index já temos a verificação
  #e para já dá jeito que seja possível fazer sign_up
  
  before_filter :require_login

  def shoppings
    @shoppings = Shopping.all
  end
  
   def lojas
      @shopping = Shopping.find(params[:id])
      @lojas = @shopping.lojas.all
  end
  
  def promos
      @shopping = Shopping.find(params[:shopping_id])
      @loja = @shopping.lojas.find(params[:lojas_id])
      @promos = @loja.promos.all   
  end
  
  def filmes    
      @shopping = Shopping.find(params[:id])
      @filmes = @shopping.filmes.all
  end
  
  def eventos
      @shopping = Shopping.find(params[:id])
      @eventos = @shopping.eventos.all
  end
  
 def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to log_in_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
  def index
    if current_admin == nil
      redirect_to log_in_url, :notice => "Tem de fazer login!"
    elsif @current_admin.tipo == nil
      @shoppings = Shopping.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @shoppings }
      end
    elsif @current_admin.tipo == 1
      redirect_to admins_lojas_path(@current_admin.idref)
    elsif @current_admin.tipo == 2 
      loja = Loja.find(@current_admin.idref)
      redirect_to admins_promos_path(loja.shopping_id, loja)
    end

  end

end
