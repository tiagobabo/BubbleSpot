 # -*- coding: utf-8 -*-

class SessionsController < ApplicationController
  set_tab :log_in
  def new
      

    if session[:admin_id] != nil
      redirect_to admins_index_url
    end
  end

  def create

    admin = Admin.authenticate(params[:email], params[:password])
    if admin
      session[:admin_id] = admin.id
      if admin.tipo == 0
        session[:tipo] = "Administrador"
      elsif admin.tipo == 1
        session[:tipo] = "Gestor de Shopping"
      elsif admin.tipo == 2
        session[:tipo] = "Gestor de Loja"
      end
      redirect_to admins_index_url
    else
      flash.now.alert = "E-mail ou password inválido!"
      render "new"
    end
  end

  def destroy
    session[:admin_id] = nil
    session[:tipo] = nil
    redirect_to log_in_url, :notice => "Logged out!"
  end

end
