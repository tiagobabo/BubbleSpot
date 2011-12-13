class AdminsController < ApplicationController
  
  #before_filter :require_login
  #este before_filter acaba por não ser necessário(?)
  #visto que no index já temos a verificação
  #e para já dá jeito que seja possível fazer sign_up
  
  before_filter :require_login_geral

  def shoppings
    if @current_admin.tipo == 0
      @shoppings = Shopping.all
    elsif @current_admin.tipo == 1
      @shoppings = [Shopping.find(@current_admin.idref)]
    else
       redirect_to admins_index_url, :alert => "Não tem permissões para gerir shoppings!"
    end
  end
  
   def lojas
      @shopping = Shopping.find(params[:id])
      @lojas = @shopping.lojas.all
      if @current_admin.tipo == 1 and current_admin.idref != @shopping.id
        redirect_to admins_index_url, :alert => "Não tem permissões para gerir as lojas desse shopping!"
      elsif @current_admin.tipo == 2 
        loja = Loja.find(@current_admin.idref)
        @lojas = [loja]
        if @shopping.id != loja.shopping_id
          redirect_to admins_index_url, :alert => "Não tem permissões para gerir as lojas desse shopping!"
        end
      end
  end
  
  def promos
      @shopping = Shopping.find(params[:shopping_id])
      @loja = @shopping.lojas.find(params[:loja_id])
      @promos = @loja.promos.all
      if @current_admin.tipo == 1 and current_admin.idref != @shopping.id
        redirect_to admins_index_url, :alert => "Não tem permissões para gerir as promoções dessa loja!"
      elsif @current_admin.tipo == 2 
        loja = Loja.find(@current_admin.idref)
        if @shopping.id != loja.shopping_id
         redirect_to admins_index_url, :alert => "Não tem permissões para gerir as promoções dessa loja!"
        end
      end   
  end
  
  def filmes    
      @shopping = Shopping.find(params[:id])
      @filmes = @shopping.filmes.all
      if @current_admin.tipo == 1 and current_admin.idref != @shopping.id
        redirect_to admins_index_url, :alert => "Não tem permissões para gerir os filmes desse shopping!"
      elsif @current_admin.tipo == 2
        redirect_to admins_index_url, :alert => "Não tem permissões para gerir os filmes desse shopping!"
      end
  end
  
  def eventos
      @shopping = Shopping.find(params[:id])
      @eventos = @shopping.eventos.all
      if @current_admin.tipo == 1 and current_admin.idref != @shopping.id
        redirect_to admins_index_url, :alert => "Não tem permissões para gerir os eventos desse shopping!"
      elsif @current_admin.tipo == 2
        redirect_to admins_index_url, :alert => "Não tem permissões para gerir os eventos desse shopping!"
      end
  end
  
 def new
    if @current_admin.tipo == 0
      @admin = Admin.new
    else
      redirect_to admins_index_url, :alert => "Não tem permissões para adicionar utilizadores!"
    end
  end

  def create
    if @current_admin.tipo == 0
      @admin = Admin.new(params[:admin])
      if @admin.save
        redirect_to admins_index_url, :notice => "Registo efetuado!"
      else
        render "new"
      end
    else
      redirect_to log_in_url, :alert => "Não tem permissões para adicionar utilizadores!" 
    end
  end
  
end
