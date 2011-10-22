class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_admin
  helper_method :require_login
  
  private

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end
  
  def require_login
    unless current_admin
      flash[:error] = "Precisa de fazer login!" 
      redirect_to log_in_url # Prevents the current action from running
    end
  end
  
end
