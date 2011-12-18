 # -*- coding: utf-8 -*-

class AdminsController < ApplicationController
  
  #before_filter :require_login
  #este before_filter acaba por não ser necessário(?)
  #visto que no index já temos a verificação
  #e para já dá jeito que seja possível fazer sign_up
  
  before_filter :require_login_geral
  set_tab :gestao

  def users

    @utilizadores = Admin.all
    
    @utilizadores.each do |user|
      if user[:tipo] == 0
        user[:tipo2] = "Admiministrador Global"
        user[:idref2] = "Todos"
      elsif user[:tipo] == 1
        @shopping = Shopping.find(user.idref)
        user[:tipo2] = "Admiministrador Shopping"
        user[:idref2] = @shopping.nome
      elsif user[:tipo] == 2
        @loja = Loja.find(user.idref)
        user[:tipo2] = "Admiministrador Loja"
        user[:idref2] = @loja.nome
      end
    end
  end

  def shoppings
    set_tab :shopping
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

  @shops = []
    @shoppings = Shopping.order("nome")
    @shoppings.each do |shopping|
      @shops += [[shopping.nome, shopping.id]]
       end
    @loj = []
        @lojas = Loja.all
        @lojas.each do |loja|
          @loj += [[loja.nome, loja.id]]
        end
   
    if @current_admin.tipo == 0
      @admin = Admin.new
      @tipos = [['Administrador Global',0],['Administrador Shopping',1],['Administrador Loja',2]]
    else
      redirect_to admins_index_url, :alert => "Não tem permissões para adicionar utilizadores!"
    end
  end

   def edit
    if @current_admin.tipo == 0
      @admin = Admin.find(params[:admin])

      if @admin.tipo == 1 

         @pos_shop = @admin.idref 
         @shops = []
         @loj = [[" ", -1]]
      elsif @admin.tipo == 0
        @loj = [[" ", -1]]
        @shops = [[" ", -1]]
      else
         @shops = []
          @loj = []
      end 


    
    @shoppings = Shopping.order("nome")
    @shoppings.each do |shopping|
      @shops += [[shopping.nome, shopping.id]]
       end
  
        @lojas = Loja.all
        @lojas.each do |loja|
          @loj += [[loja.nome, loja.id]]
          if @admin.tipo == 2
            if loja.id == @admin.idref
              @pos_shop = loja.shopping_id
            end
          end 
        end
    @tipos = [['Administrador Global',0],['Administrador Shopping',1],['Administrador Loja',2]]

    

      if params[:tipo] == "1"
        params[:admin][:idref] = params[:shop]
        
      elsif params[:tipo] == "2"
        params[:admin][:idref] = params[:loj]

      end

    else
      redirect_to admins_index_url, :alert => "Não tem permissões para editar utilizadores!"
    end
  end

  def create
    if @current_admin.tipo == 0
      if params[:tipo] == "1"
        params[:admin][:idref] = params[:shop]
        
      elsif params[:tipo] == "2"
        params[:admin][:idref] = params[:loj]

      end
       params[:admin][:tipo] = params[:tipo]
  
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


  def update
    
    @admin = Admin.find(params[:admin_id])

    if params[:tipo] == "1"
        params[:admin][:idref] = params[:shop]
        
      elsif params[:tipo] == "2"
        params[:admin][:idref] = params[:loj]

      end
       params[:admin][:tipo] = params[:tipo]


    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html {  redirect_to admins_users_url , :notice => 'O utilizador foi editado com sucesso.' }
      else

if @admin.tipo == 1 

         @pos_shop = @admin.idref 
         @shops = []
         @loj = [[" ", -1]]
      elsif @admin.tipo == 0
        @loj = [[" ", -1]]
        @shops = [[" ", -1]]
      else
         @shops = []
          @loj = []
      end 


    
    @shoppings = Shopping.order("nome")
    @shoppings.each do |shopping|
      @shops += [[shopping.nome, shopping.id]]
       end
  
        @lojas = Loja.all
        @lojas.each do |loja|
          @loj += [[loja.nome, loja.id]]
          if @admin.tipo == 2
            if loja.id == @admin.idref
              @pos_shop = loja.shopping_id
            end
          end 
        end
        @tipos = [['Administrador Global',0],['Administrador Shopping',1],['Administrador Loja',2]]


        format.html { render :action => "edit" }
      end
    end
  end

  def destroy

    if @current_admin.tipo != 0
      redirect_to admins_index_url, :alert => "Não tem permissões para apagar utilizadores!"
    else
       
          @admin = Admin.find(params[:admin])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admins_users_url , :notice => 'O utilizador foi eliminada com sucesso.' }
      format.xml  { head :ok }
    end
    end
  end
  
end
