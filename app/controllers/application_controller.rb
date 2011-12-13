 # -*- coding: utf-8 -*-

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_admin
  helper_method :require_login
  helper_method :require_login_geral
  
  private

  def current_admin
    if Admin.count > 0
      @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
    else
      @current_admin = nil
    end
  end
  
  def require_login_geral
    unless current_admin
      redirect_to log_in_url, :alert => "Não tem permissões de gestão!"
      
    end
  end

  def require_login(id, idref=-1)
    unless current_admin
      redirect_to log_in_url, :alert => "Não tem permissões de gestão!"
    end

    if id == 0
      unless @current_admin.tipo == 0
        redirect_to admins_index_url, :alert => "Não tem permissões de gestão!"
      end
    elsif id == 1
      unless (@current_admin.tipo == 1 and @current_admin.idref.to_s == idref.to_s) or @current_admin.tipo == 0
        redirect_to admins_index_url, :alert => "Não tem permissões de gestão!"
      end
    elsif id == 2
      unless (@current_admin.tipo == 2 and @current_admin.idref.to_s == idref.to_s) or (@current_admin.tipo == 1 and @current_admin.idref.to_s == Loja.find(idref).shopping_id) or (@current_admin.tipo == 0)
        redirect_to admins_index_url, :alert => "Não tem permissões de gestão!"
      end
    end
  end
  
end
